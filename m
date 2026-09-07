Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D5235DA47
	for <virtualization@lists.linux.dev>; Mon,  7 Sep 2026 18:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788806158; cv=none; b=iam54QSK7UDaI88h/xEdKxbScAcC/Q/d7ukLPwZQ9HiRzWkJ7XpMOz94kDJnLht/ggdA+Mq2gkFGBMgEbTrGtwaxv63lrQCntYHuYmR1uojp5Mb1ywwGy6wMpAdmWJFAYS7vQMjWAwhPrPcSWY6uvPdTlaXTplrjzE+UyaEVkGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788806158; c=relaxed/simple;
	bh=cv04HKy4otmKMhqnEPI0LZjhku21UWf61AeAHYiBERc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jsby7RqzQyCWAde0UraIgAma+EodvTL/5sDQPRd5S6xHfkKrEcTJTpfZKZQQVUTVRiURaE0Z9z3ByQVK4cqDYLq2x1i55Z3SaV3k+XDM5FS9yxrvXWkcGkAmYLyD3x4uDn2Ee/YqOJPY+/UliqHDH4qb9PsvbWDuor6b48d4mxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ed8ap+4t; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ed8ap+4t"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-398b3c37877so3464526a91.0
        for <virtualization@lists.linux.dev>; Mon, 07 Sep 2026 11:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788806156; x=1789410956; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y/QhyKnaiEuCX/YyxX6dbFuiwyxx+yL27o8G1/oLGwk=;
        b=ed8ap+4tesegQJ8LTMu/u23LTTgK6VRaI7sTZ/xR9rhEUPjimzxFkV/yorKnnfW2p9
         VgGveyz3ei3WCRkZiERF0DgzaKiEa58InAt6Nty2NmU7m7GqB/TEvjQvqMVLIQ2T3KYz
         IFk/7azw7vKhWGGtEGFqhUszcAiJfQEnJXzKn03RMZxXzp3YPXSpb+g+l2wvuXW7f33+
         LTDl2lz0eo+eNaLxX2IYGF8jPzZ2j5pf2n4/EeYaSdyIPXEn9BKKa4JcHiXrcL88YL9r
         h8EohJh0EY6gBv67g/08Hx9kl6Hi6JexlAsBCwmxTGNF/g+FFs7IOMnXZU562xwF2sgZ
         xSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788806156; x=1789410956;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y/QhyKnaiEuCX/YyxX6dbFuiwyxx+yL27o8G1/oLGwk=;
        b=CSfKqRuuTj9tohBHzMWkJB+gOeEOC8yLNJVk0mepKLHlzRNqQ33N8QgrIAjkwfcWrp
         AUsOFbiT6FH6Pv1ykBpaIo7ulfMp9jrK0GGHnAX1ZFu0njresLcoUbCmyJsRMBpfJzvI
         QaXPcaMftoDmipQhXdWjHyv6yOCh+ZtuWmMUZYeDRctFgZGLy/Liq3cauROuUqp4XCVL
         YcacvtzyYamPlCdb5kIgl4zcpo9xCb+vpm7KzCoGd7KY/pX1bSDl+T5WBKrX2s/N45Hy
         YNLs3lF99nze59XvbOBWUyDg58KB3+iQ2eEgbQUkovjDDwfjl7hxEmmhET+GtK7+fwQf
         RsTg==
X-Forwarded-Encrypted: i=1; AKwUvBzbAl5Uf/j9HSH6gNIEGlMta4nVIJMQUOSrGxwLRqEKZi5hb7f8AsmeBRvL0lY24VfP5Xz36pooQWxU7yRycw==@lists.linux.dev
X-Gm-Message-State: AFuF++kPL0aLZOMfYr64i0hWc0gMQn0WK3c5/IJ1js3tKjopaIGjQw9j
	CXGkS/vf2CfIjqQLnBwsHVdF+2I1/fz9VczcQXP2+bWUIdZQVvEXMSfQ
X-Gm-Gg: AYBFou13pZLyJGrnRQjTlDmbYQCPQu6QT3cZlCPWbZA74bnKTkl5uyD0z24kWTYdVvW
	dvl02CUbUzH/aZdfgsOg2xNDw6x/XLUQ2k1NYHY1KCNuW4QnEYbAsO0LV+bFq4iC4nfTTdDCq22
	h4X+32+6k7ah4z34iEi61yOW+68Eslu4nBeaAx8lQPwN+yuwYMsYhWbtzvNeqi7yUqO4OV4J8GI
	OkyGsd6dZnUeKj9Pv5Q55OUTfzqnRgnmoI9pV7ZfDGyTW2KiNB5pQpAuWZYlz3p/dbCjUIl25DT
	fYjEL5r2c/voHqhkBZpcWEZQk3i6wC19VO84raDsiSlhUsC+XBuN4GXgVSr7XSEE4Nk2qc8h9gN
	DxVeLuaIGO+r0afqqflKn/3rAmfVjmqZJVp+EM4AT6/cdWZX+rm3tKMwF729ruzhd1exAxssq0T
	4OV47d7MM8JmVDc2cgzt86Ueoc0fRMxD1kHawoptba6qyOH0PAN9TC1ggocT1lcGMJ3rohvNOuq
	qJjgAnK
X-Received: by 2002:a17:90b:5289:b0:398:e96a:8999 with SMTP id 98e67ed59e1d1-39b261d0d83mr39934040a91.16.1788806155950;
        Mon, 07 Sep 2026 11:35:55 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b51eb40e6sm12393181a91.16.2026.09.07.11.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 11:35:55 -0700 (PDT)
Date: Tue, 8 Sep 2026 03:35:51 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Michal Luczaj <mhal@rbox.co>, Stefano Garzarella <sgarzare@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, leonardi@redhat.com,
	bobbyeshleman@meta.com, stefanha@redhat.com, mst@redhat.com,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	imv4bel@gmail.com
Subject: Re: [PATCH net] vsock: do not reset a socket in connect() once it
 has connected
Message-ID: <ap8EBx3pkSr5Csy1@v4bel>
References: <anzT1fREOSyHT99k@v4bel>
 <218226a4-38e6-4a16-a660-6c1bb92f9f96@rbox.co>
 <an5zJ9Uf94_L9TyB@v4bel>
 <c11d6fe8-fdf9-4b45-b291-e5d5b0ef5cb4@rbox.co>
 <aoVnp0w9jlyFDPj7@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoVnp0w9jlyFDPj7@sgarzare-redhat>

On Wed, Aug 19, 2026 at 10:54:38AM +0200, Stefano Garzarella wrote:
> On Mon, Aug 17, 2026 at 12:29:11AM +0200, Michal Luczaj wrote:
> > On 8/14/26 03:45, Hyunwoo Kim wrote:
> > > On Thu, Aug 13, 2026 at 11:42:17AM +0200, Michal Luczaj wrote:
> > > > On 8/12/26 22:13, Hyunwoo Kim wrote:
> > > > > commit 002541ef650b ("vsock: Ignore signal/timeout on connect() if
> > > > > already established") stopped connect() from resetting an established
> > > > > socket. The check only looks at whether sk_state is TCP_ESTABLISHED at
> > > > > that moment, and the state can change while connect() sleeps.
> > > > 
> > > > I guess this makes my fix incomplete. "Fixes: 002541ef650b"?
> > > 
> > > It is incomplete, yes. But this has been triggerable since d021c344051a, so
> > > I'd keep Fixes: d021c344051a.
> > 
> > OK, I get it.
> > 
> > > > > A peer RST moves the socket to TCP_CLOSING, and it is not removed from
> > > > > vsock_connected_table on that path. connect() then wakes up, fails the
> > > > > check, and resets a socket that had actually connected to TCP_CLOSE and
> > > > > SS_UNCONNECTED.
> > > > 
> > > > Thanks for the details. Do I get it right: connect() misses the fact that
> > > > socket might have already transitioned TCP_ESTABLISHED -> TCP_CLOSING
> > > > during schedule_timeout()?
> > > 
> > > Yes, that's it.
> > > 
> > > > 
> > > > How about:
> > > > 
> > > > diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> > > > index 622dbd046799..39c42ef016c3 100644
> > > > --- a/net/vmw_vsock/af_vsock.c
> > > > +++ b/net/vmw_vsock/af_vsock.c
> > > > @@ -1807,15 +1807,18 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
> > > >  		timeout = schedule_timeout(timeout);
> > > >  		lock_sock(sk);
> > > > 
> > > > -		/* Connection established. Whatever happens to socket once we
> > > > +		/* Connection (has been) established. Whatever happens to socket once we
> > > >  		 * release it, that's not connect()'s concern. No need to go
> > > >  		 * into signal and timeout handling. Call it a day.
> > > >  		 *
> > > >  		 * Note that allowing to "reset" an already established socket
> > > >  		 * here is racy and insecure.
> > > >  		 */
> > > > -		if (sk->sk_state == TCP_ESTABLISHED)
> > > > -			break;
> > > > +		if (sk->sk_state == TCP_ESTABLISHED ||
> > > > +		    sk->sk_state == TCP_CLOSING) {
> > > > +			err = -sk->sk_err;
> > > > +			goto out_wait;
> > > > +		}
> > > > 
> > > >  		/* If connection was _not_ established and a signal/timeout came
> > > >  		 * to be, we want the socket's state reset. User space may want
> > > > 
> > > > ?
> > > 
> > > Yes, I like it better than mine. I confirmed it fixes the issue.
> > 
> > Great, thanks.
> > 
> > > If you don't mind, would you take the patch from here?
> > 
> > Sure, no problem.
> > 
> > Stefano, does this look good to you?
> 
> Yep, thanks for helping here!
> 
> My only doubt is if it makes sense to leave the `break` there, and add a
> similar check before resetting the socket, I mean something like this:
> 
> 	err = sock_error(sk);
> 	if (err && sk->sk_state != TCP_ESTABLISHED &&
> 		   sk->sk_state != TCP_CLOSING)) {
> 		sk->sk_state = TCP_CLOSE;
> 		sock->state = SS_UNCONNECTED;
> 	}
> 
> Just to be a bit more defensive, but I don't have a strong opinion, your
> version is also fine.
> 
> > And should any sk_err be consumed
> > here, too? (`err = sock_error(sk)` instead of `err = -sk->sk_err`)
> 
> I'd stay with sock_error() to consume the error if it makes sense also for
> you.
> 
> Thanks,
> Stefano
> 

Gentle ping. I'd appreciate an update on where this stands.


Best regards,
Hyunwoo Kim
