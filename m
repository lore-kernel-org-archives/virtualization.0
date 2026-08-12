Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EE936CDF8
	for <virtualization@lists.linux.dev>; Wed, 12 Aug 2026 20:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786565596; cv=none; b=lEOR7/K2Ajnvs5FwhZ1hnGGKKE6q/VTNOtYyZgIVSqxrK55O1InhKUpBkbFxPl7RktmjmInoFUT2zordSlrKqU2yos4IhH1nBkJmJNUGVuAMPjtEWVZOb8MfCionJjYctLrSBBiqCbm8obuLnY5Y983eP9woJ6SBVol1V1EuQB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786565596; c=relaxed/simple;
	bh=atcv5mB75yvrhGDP+UBiVutUbuMq+/hDkVgOZSQoEek=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qvg8ftrSmCLsCltMPvOJIWRtCPPZBGo4xs0Sd56GTVvSoeLmH6Vdmg3yv76jBaL2UTAoXp+gWlOvpdv7BmLQTm2qFBtMPvoUoLYtct81iaU+Gk2Nhlf5QQB+UWnRwQkjdrb3T3fhMq8CLTlQohggskqRmwBOyWHalyaild/q07k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rZyxiPeN; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rZyxiPeN"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38101f85591so271707a91.1
        for <virtualization@lists.linux.dev>; Wed, 12 Aug 2026 13:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786565594; x=1787170394; darn=lists.linux.dev;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=50/tctT413AwEP9BINIhVKAqs22RAZ6gO6ugPDW/HS8=;
        b=rZyxiPeNa8a3iclFLbR1++6zCf3a6miK+tt3biBcODby44haMMkeoPzncxHBE3ZeR9
         aDBDWeJ002z9DHiBFcHv/BNpLut0o/pZhaRGF+dpwiBZWNqv5bvKQp/RHLvUX08l51s7
         a903BdOeXOgLhH6bqcOg1JdEzJAm/hnS0G0ayTPAknxktaffIwUbhIbzNgeN7u6tyv4b
         2mKr3QnNN1cSAMBqbEhv4VhCt23pJa5WOljntH/mHM7jHlaGztBWaOAWnrggj44hlW5c
         WeedG76HD0d26mwudHOpIVwYuFqreEMqiz3bNEx1N5UMe+tM8/B3Kgrrpqg0zC1SOBTd
         Um4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786565594; x=1787170394;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=50/tctT413AwEP9BINIhVKAqs22RAZ6gO6ugPDW/HS8=;
        b=kkijULDjuwotFbWbp1XIkXGj4uYzC6PVvCQCtVP9yWu7D95dg7LX9V2i9JLm9glAlS
         fCNeJB9j5XLqHTSw9kTNOBRmXu6oNRSgaTyYgFGoioA2wKIj4s40o33kuv/p4nHVpM8q
         eu82m5TZJhUiQ9hNCv5+KjtTIvny4B049UYHEY8lOchgk3gq2wZR+7HszmbmPWf+de9u
         07KiFN2yQIHWdn1sO2Gx+g40bUjFZ3VJ9ttpRiblGQDz94EwZ/rho0jL/1Gw6RTIBjt3
         4tBo8eZEPNUsm0GISqt6qoREh3kKDhBmgG68kSNh14pXqaU/1CQOI115AJu5D8V8xAkZ
         M3cg==
X-Gm-Message-State: AOJu0Yx6YMefx2Z1c+7slxlrGD+VvyaVGQtbURF5yzHKDlkdb7Popek/
	c+lUzNG5L5DKcRo8dylw49xrjRDjZMFJ6uh9o+n8psvVXtWrXInCb7xh
X-Gm-Gg: AR+sD12N+28usxpRudADihjkwuO6fjn9U5H6wESjP/RkFrAb8b7vXpowoJltJCCXZPs
	7EP/ctptekl0BZoKksZqP8qYLpJTMD7q2ZVmwxsxHZYH4k2P/9ymXm8UQDiCx4fvcEDlX+wdrve
	hH1G8mTINmZqb6lWNkpUDUkigOOHZUbfHjwtR5M91mdw1ubOBZih6/GFhYyDzGbg8FdH8dw83TT
	cy79b7VZjEEzq28NHVZ82svpJL1gM34lJbH1yYN8XGRM/1O+KJkae3zc354UEFyYa/C32f8dc6R
	kR5rzwV2QlP7g8d/F+LWHw94E/98dlKwttQCQcqtpUl+4AOWjQkyAKcLzkKd3ctsi+wOs5yqxnq
	XH5aCNdTlf/wiSUV8L8fl7yHOuDCxCv9lObVlmq6D9LW/S8G0PCVS3XNrHAUlPY/wD03jZQq3nT
	X5/HLiigIQTXeGAySZy03XnGAzmjetSfL1dSKL3BlS6+w+phtvrpdcffVpC018eZX7SkhtVYN5u
	tgHSFap
X-Received: by 2002:a17:90b:35d2:b0:38f:1a29:7a82 with SMTP id 98e67ed59e1d1-3931f89bb03mr72845a91.6.1786565593913;
        Wed, 12 Aug 2026 13:13:13 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3931f44dcbbsm183267a91.16.2026.08.12.13.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 13:13:13 -0700 (PDT)
Date: Thu, 13 Aug 2026 05:13:09 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: sgarzare@redhat.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, mhal@rbox.co,
	leonardi@redhat.com, bobbyeshleman@meta.com, stefanha@redhat.com,
	mst@redhat.com
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
	imv4bel@gmail.com
Subject: [PATCH net] vsock: do not reset a socket in connect() once it has
 connected
Message-ID: <anzT1fREOSyHT99k@v4bel>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

commit 002541ef650b ("vsock: Ignore signal/timeout on connect() if
already established") stopped connect() from resetting an established
socket. The check only looks at whether sk_state is TCP_ESTABLISHED at
that moment, and the state can change while connect() sleeps.

A peer RST moves the socket to TCP_CLOSING, and it is not removed from
vsock_connected_table on that path. connect() then wakes up, fails the
check, and resets a socket that had actually connected to TCP_CLOSE and
SS_UNCONNECTED.

The socket can now be connected again while it is still on the table.
Reconnecting to an address served by a different transport makes
vsock_assign_transport() drop the transport from a live socket and free
vsk->trans, even if skbs it already sent are still in flight.
Reconnecting to the same address inserts a node that is already on the
table, provided shutdown() has cleared SOCK_DONE in between.

sock->state cannot be used for the check either. shutdown() overwrites
SS_CONNECTED with SS_DISCONNECTING.

Record on the socket that the connection completed, and check that
instead. The sk_err path after the loop does the same reset, so guard it
as well.

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 include/net/af_vsock.h   |  2 ++
 net/vmw_vsock/af_vsock.c | 12 ++++++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 30046a3c20f735..d7ec976ed6e272 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -63,6 +63,8 @@ struct vsock_sock {
 	struct delayed_work pending_work;
 	struct delayed_work close_work;
 	bool close_work_scheduled;
+	/* Set once the connection completed; never cleared. */
+	bool ever_connected;
 	u32 peer_shutdown;
 	bool sent_request;
 	bool ignore_connecting_rst;
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 622dbd04679944..735c91bb762242 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -351,6 +351,8 @@ void vsock_insert_connected(struct vsock_sock *vsk)
 	struct list_head *list = vsock_connected_sockets(
 		&vsk->remote_addr, &vsk->local_addr);
 
+	vsk->ever_connected = true;
+
 	spin_lock_bh(&vsock_table_lock);
 	__vsock_insert_connected(list, vsk);
 	spin_unlock_bh(&vsock_table_lock);
@@ -1814,14 +1816,14 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
 		 * Note that allowing to "reset" an already established socket
 		 * here is racy and insecure.
 		 */
-		if (sk->sk_state == TCP_ESTABLISHED)
+		if (vsk->ever_connected)
 			break;
 
 		/* If connection was _not_ established and a signal/timeout came
 		 * to be, we want the socket's state reset. User space may want
 		 * to retry.
 		 *
-		 * sk_state != TCP_ESTABLISHED implies that socket is not on
+		 * !ever_connected implies that socket is not on
 		 * vsock_connected_table. We keep the binding and the transport
 		 * assigned.
 		 */
@@ -1849,8 +1851,10 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
 
 	if (sk->sk_err) {
 		err = -sk->sk_err;
-		sk->sk_state = TCP_CLOSE;
-		sock->state = SS_UNCONNECTED;
+		if (!vsk->ever_connected) {
+			sk->sk_state = TCP_CLOSE;
+			sock->state = SS_UNCONNECTED;
+		}
 	} else {
 		err = 0;
 	}
-- 
2.43.0

