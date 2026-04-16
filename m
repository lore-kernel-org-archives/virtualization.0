Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E9F34D90E
	for <virtualization@lists.linux.dev>; Thu, 16 Apr 2026 19:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776366906; cv=none; b=kfUT+fGDnnOuhXzgoQM0IWlgr2EyoMD9j7z7xRHEpL3eyDsvctnDw17WLHYvrDSoBWD0KmHdlWyXQFx+xI2Q7Bnw8w9uZx3LGn/5EH+KKWCKvV9EuTWFK5whgJ8Y6JqRuP1OR0Q6VR1eYrKONil2l5xtVkUkfBDNYEXpBqCvgSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776366906; c=relaxed/simple;
	bh=pxExjy9+COVofPKPelAFl6ZTZDTzl6NhBpiM4c7aFVI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=newZRfbUwT/tWATFuFrvpJ0KAB7AmTqsLepE5L/2SWlS2vV0XBZ1BQL2rhF/RJVi6/OdZrZ00SaobsSZ0c5Xx2xtMdTlyXAHmXmRyl9Ky8gSOpVc8QML1g8ERSQw7zq9tBv2wJTP6XcLQDd+7SioRbm5rXHhwRgU7jthJ3p+Lb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1009)
	id A080C20B7128; Thu, 16 Apr 2026 12:15:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A080C20B7128
From: Dexuan Cui <decui@microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	sgarzare@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	niuxuewei.nxw@antgroup.com,
	linux-hyperv@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Ben Hillis <Ben.Hillis@microsoft.com>,
	Mitchell Levy <levymitchell0@gmail.com>
Subject: [PATCH net v2] hv_sock: Report EOF instead of -EIO for FIN
Date: Thu, 16 Apr 2026 12:14:33 -0700
Message-ID: <20260416191433.840637-1-decui@microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit f0c5827d07cb unluckily causes a regression for the FIN packet,
and the final read syscall gets an error rather than 0.

Ideally, we would want to fix hvs_channel_readable_payload() so that it
could return 0 in the FIN scenario, but it's not good for the hv_sock
driver to use the VMBus ringbuffer's cached priv_read_index, which is
internal data in the VMBus driver.

Fix the regression in hv_sock by returning 0 rather than -EIO.

Fixes: f0c5827d07cb ("hv_sock: Return the readable bytes in hvs_stream_has_data()")
Cc: stable@vger.kernel.org
Reported-by: Ben Hillis <Ben.Hillis@microsoft.com>
Reported-by: Mitchell Levy <levymitchell0@gmail.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

Changes since v1:
    Removed the local variable 'need_refill' to make the code more 
    readable. Stefano, thanks!

    No other change.

 net/vmw_vsock/hyperv_transport.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index 069386a74557..e5ee7aa14d0c 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -694,7 +694,6 @@ static ssize_t hvs_stream_enqueue(struct vsock_sock *vsk, struct msghdr *msg,
 static s64 hvs_stream_has_data(struct vsock_sock *vsk)
 {
 	struct hvsock *hvs = vsk->trans;
-	bool need_refill;
 	s64 ret;
 
 	if (hvs->recv_data_len > 0)
@@ -702,9 +701,22 @@ static s64 hvs_stream_has_data(struct vsock_sock *vsk)
 
 	switch (hvs_channel_readable_payload(hvs->chan)) {
 	case 1:
-		need_refill = !hvs->recv_desc;
-		if (!need_refill)
-			return -EIO;
+		if (hvs->recv_desc) {
+			/* Here hvs->recv_data_len is 0, so hvs->recv_desc must
+			 * be NULL unless it points to the 0-byte-payload FIN
+			 * packet: see hvs_update_recv_data().
+			 *
+			 * Here all the payload has been dequeued, but
+			 * hvs_channel_readable_payload() still returns 1,
+			 * because the VMBus ringbuffer's read_index is not
+			 * updated for the FIN packet: hvs_stream_dequeue() ->
+			 * hv_pkt_iter_next() updates the cached priv_read_index
+			 * but has no opportunity to update the read_index in
+			 * hv_pkt_iter_close() as hvs_stream_has_data() returns
+			 * 0 for the FIN packet, so it won't get dequeued.
+			 */
+			return 0;
+		}
 
 		hvs->recv_desc = hv_pkt_iter_first(hvs->chan);
 		if (!hvs->recv_desc)
-- 
2.49.0

