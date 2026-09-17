Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EB73A4523
	for <virtualization@lists.linux.dev>; Thu, 17 Sep 2026 22:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789682484; cv=none; b=flSN1HTMfCPr5DbwOKbYHLm03cIzUriDWIt6HtGdQDp7BBwuRt7IbrSSZNj5KwqvnIvNyi3JyM7Z6p2Tm5XrBveFHJxwps1UFZvLyMhSvOGQSzK57H5wAGkFJwrNiyboS4ueYP1E+BnNFnKGr+msOVzv6KzxxEYYsJmsq0MYOBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789682484; c=relaxed/simple;
	bh=P5/CfOGFGVjMXctTHGuF1aX3rpeY4JVXEkJv3aLXfN8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N/kLxg8CsdQbS5T9Jg2SFGaoHO+hmOGkYRHRLfhElYJlScEUzaX1Wyf+a08LOsr3EtOYdl0C4XMS6QCqJOKz8+diPvgQT0ILW5n8UxlfHk7FO9AdbfQyhUi3y2mAunI8V8uNNTpR6a/d0r9cin4WA5/uPqaDd5CZ6yXLJhP+Mr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isec.pl; spf=pass smtp.mailfrom=isec.pl; dkim=pass (2048-bit key) header.d=isec.pl header.i=@isec.pl header.b=QGE+ZpHJ; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isec.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isec.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isec.pl header.i=@isec.pl header.b="QGE+ZpHJ"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e79a408deso480185e9.2
        for <virtualization@lists.linux.dev>; Thu, 17 Sep 2026 15:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isec.pl; s=google; t=1789682480; x=1790287280; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ro6SttdQWiVFkbJS47mTtfdYN9m9RFgqNhFOaAFAJrw=;
        b=QGE+ZpHJGE2wxSelf0v6qy9KtTdxO2VS2oWYNGWYpnXjDEXdLydQZSi3JJl1K6qNVH
         3yEL266a/3F24A5sT02iWqhp/MbD+FxmgJ5dFdeBYQC1ekvb5AhR+ozVLhiJuybdB8r0
         s3iXPBH2U5Ql1x8b9xgo3rmDxJrp4JGX71+Y1oEnv4TLbIJiNIV1tFJqIyv/BDJAWmDS
         MOSq3Z8ERNIOqWlfyfmJ33fwoTekEzDW1B6XetDempPWXhCUl4R7978RvOQti2uzrcJb
         SuE0WRhwe8ej/O4nkFSLoi6hQ6jLgo086gUYtnU6q7E/+T4GG6TnnoBm+wSC3hDovWPO
         cyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789682480; x=1790287280;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ro6SttdQWiVFkbJS47mTtfdYN9m9RFgqNhFOaAFAJrw=;
        b=0ELFHRznnhiSya9Tk+IFcs/uaAOlae4Ub3E0QEiaUso1gKfdZ73TCJAM/33X2mA9Vn
         YFRfsI8SLGfCfKUazRxzDDSD41om0Xo97B3ZyxExbGG/MZnVzfoOxI9Coeux6r6u2Wj5
         befd++SmF9XseJ0xn9h+uP1q5NzwOk3nTRsAg2bDVWl14zcHVZiAVWmYhtuoCc+pnJ12
         e35xJUuDtZixTurZovEDg9XzvrwLW7V/4ZZfrYDLOkpEKIpQ/Hi3cHYG5tcNhpEgnJ02
         PLAi125jR3VSWeKBy+o3xzofBHACJk7zKShQlW7pqn/822uGorfZi0w4PBzHpZ/urgi0
         pmTg==
X-Forwarded-Encrypted: i=1; AKwUvBzY7fXHATj56V4suz2j5av7X0LK3I7g+RIgVKSlbpbrW5OqO1WsqU5C0P/0+L56sQ17irrZ6Ae32o+doBNYdg==@lists.linux.dev
X-Gm-Message-State: AFuF++mxT8BTYtGbTFTaajK5tf23xfFf2lJRJeja6GLn2J5W71GdNZMB
	5H7g/WaSjZJ+M+SagqX9XbVCaqrbhSvzSFTm8Sv0ZIryIi5vEtqVMb3A068F1C0DbDk=
X-Gm-Gg: AYBFou1o3SUNNskxHKJ569yHU+eXWAGeKEln1M+8WNcLme7/aOW4/B1Yx9VUuzDe7t+
	ndeIkbVTx81H9oj3+AEtfpceCkukKwc6hv+Cv44nlYyFI/IV4iZZMxRh5lpdRNEzX/o7Ct1Uka6
	WkMx/7pY3j98/JJ1Z/mgyaRnHVHFL1dskHlDsHNUI/zsxdOzGkp9GUkjHUzhnt+T2sH3idEoOq5
	9JaELoO/AuTj69Nr8VEWbD52AuaOroCge8C78dEkbto+wb6VKqhWiiXsbBfUJdhQ6U/S0c2q9vc
	rusPL3JL2h9VfaR+PguBbSooHxvZ1HDnTF4pK8WCP7vg6Iqtc8E/1NXhnBqZQ9SQqRQ3shNv8rH
	A0A/QfaI0fKlaYR2uYqo0h5AZUg8A6goZLasB0LLbcjuFuwZBBMvnmZ0ItfvSo32IMi96yQCVrx
	Ui0vl7AZ+ojhAqEO3iAdKVmsPhflmN2//2B98Jf5OmHz6h345gCJ/gnA62sjM2q0y4l2n2UZ57r
	sNZ1w8smfFXwjbXu+TIbNftRXRyEM9xU8qB+qz1I95Rf9FO
X-Received: by 2002:a05:600c:4e46:b0:49e:642a:4f6f with SMTP id 5b1f17b1804b1-49fc585e9edmr2469425e9.33.1789682479877;
        Thu, 17 Sep 2026 15:01:19 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a318:80b3:9080:744c:a1ba:d233:283a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc6ca43edsm1669305e9.0.2026.09.17.15.01.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Sep 2026 15:01:19 -0700 (PDT)
From: =?UTF-8?q?Bart=C5=82omiej=20Dmitruk?= <bartlomiej.dmitruk@isec.pl>
To: Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org
Subject: [RFC PATCH] vsock: keep SOCK_SEQPACKET message boundaries on interrupted send
Date: Fri, 18 Sep 2026 00:01:00 +0200
Message-ID: <20260917220101.55744-1-bartlomiej.dmitruk@isec.pl>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A credit-limited SOCK_SEQPACKET send transmits fragments as credit becomes
available, and the VIRTIO_VSOCK_SEQ_EOM flag is set only on the fragment
where msg_data_left() reaches 0.  If vsock_connectible_sendmsg() exits via
out_err after a partial send -- notably the non-terminal -EINTR path
(signal_pending while blocked for credit), but also sk_err / peer
RCV_SHUTDOWN -- the already-transmitted fragments carry no EOM.  The
receiver only advances msg_count / sets msg_ready on an EOM skb, so the
orphaned fragments are silently merged into the *next* message, violating
SOCK_SEQPACKET atomicity.

Reproduced on vsock_loopback: an -EINTR-aborted partial send of 'A's is
merged into the next 'B' message; recv() returns one [A...][B...] message
instead of just the 'B' message (reproducer + before/after below the ---).

Since a SEQPACKET message is bounded by min(peer_buf_alloc, buf_alloc)
(EMSGSIZE gate in virtio_transport_seqpacket_enqueue()), the sender can
wait for room for the whole remaining message before enqueuing, so the
message is committed atomically or not at all; an error while waiting then
leaves nothing on the wire.  SOCK_STREAM behaviour is unchanged
(min_space == 1 reproduces the old "wait while space == 0").

RFC: an alternative is to close a partially-sent message with an explicit
EOM on the error path; feedback on the preferred approach welcome.

Signed-off-by: Bartłomiej Dmitruk <bartlomiej.dmitruk@isec.pl>
---

Testing (vsock_loopback, unprivileged, single process; reproducer in
t_vuln004.c): receiver buf_alloc=16384; a 14000-byte message is left unread
to shrink credit to 2384; an 8000-byte message is sent with alarm(1) so the
send is interrupted (-EINTR) after a partial 2384-byte fragment; the 14000
message is drained; then a 1000-byte message is sent.

  before: recv() returns one 3384-byte message = 2384 'A' (orphan) + 1000 'B'
  after:  recv() returns one 1000-byte message = 1000 'B'   (boundary intact)

Normal SEQPACKET send/recv (the 14000- and 1000-byte whole messages) works
unchanged.

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -2250,9 +2250,16 @@
 
 	while (total_written < len) {
 		ssize_t written;
+		/* For SEQPACKET wait until the whole remaining message fits, so
+		 * it is enqueued atomically.  A credit-limited partial send that
+		 * then errors out (e.g. -EINTR) would otherwise leave EOM-less
+		 * fragments that the peer merges into the next message.
+		 */
+		s64 min_space = (sk->sk_type == SOCK_SEQPACKET) ?
+				(s64)(len - total_written) : 1;
 
 		add_wait_queue(sk_sleep(sk), &wait);
-		while (vsock_stream_has_space(vsk) == 0 &&
+		while (vsock_stream_has_space(vsk) < min_space &&
 		       sk->sk_err == 0 &&
 		       !(sk->sk_shutdown & SEND_SHUTDOWN) &&
 		       !(vsk->peer_shutdown & RCV_SHUTDOWN)) {
