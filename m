Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A578C7EE22
	for <virtualization@archiver.kernel.org>; Thu, 11 May 2023 05:31:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BFA42616B1;
	Thu, 11 May 2023 05:31:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BFA42616B1
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=BfOwgjFL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6f6-dNsVxmkG; Thu, 11 May 2023 05:31:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3F7FB60D89;
	Thu, 11 May 2023 05:31:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3F7FB60D89
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F8CAC0037;
	Thu, 11 May 2023 05:31:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A043BC002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 May 2023 05:31:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 71CD3405EC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 May 2023 05:31:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 71CD3405EC
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk
 header.a=rsa-sha256 header.s=zeniv-20220401 header.b=BfOwgjFL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uQFpu0kifxC2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 May 2023 05:31:39 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0E1784013F
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk
 [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0E1784013F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 May 2023 05:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=sImtSEdeoH0kaJWNfpZ5Fj7UjlwzA50TxaE7LHZUU+U=; b=BfOwgjFL6GdoKA3/MhZfq945FU
 B8H7AiawPq2LjLZFlbJYtIgzCNaJ/ZSK7ikij7A1I1uUx1Svhbn3BfRlkeFgvvMTfMnzbDHvZFJqA
 +eDL/3DBjN/IYXh9Ox2V3iUrezO5oMRkPFkWIOPwQNl7Pwu8QjoTAsn0em1THyhgjM/5mFalU93R4
 INtQ6qCQ+L5vad3oJq3q83POwFVrVfa8W8s6REmY2jjjc1YGjjrBK/d2MV/4rc6Zwt4NlTj4E9PHJ
 JZj0hlTv7esatCf8mZh1n8tVEbHkG2PQKQs5uQHULGyXhr/7G8P7zSURKG+YXjdkJOjZ7x5MIUn8L
 LRcQVDkw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1pwyth-001cUh-1C; Thu, 11 May 2023 05:31:25 +0000
Date: Thu, 11 May 2023 06:31:25 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: ye.xingchen@zte.com.cn
Subject: Re: [PATCH] vhost_net: Use fdget() and fdput()
Message-ID: <20230511053125.GI3390869@ZenIV>
References: <202305051424047152799@zte.com.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <202305051424047152799@zte.com.cn>
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, May 05, 2023 at 02:24:04PM +0800, ye.xingchen@zte.com.cn wrote:
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
> 
> convert the fget()/fput() uses to fdget()/fdput().
> 
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/vhost/net.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index ae2273196b0c..5b3fe4805182 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -1466,17 +1466,17 @@ static struct ptr_ring *get_tap_ptr_ring(struct file *file)
> 
>  static struct socket *get_tap_socket(int fd)
>  {
> -	struct file *file = fget(fd);
> +	struct fd f = fdget(fd);
>  	struct socket *sock;
> 
> -	if (!file)
> +	if (!f.file)
>  		return ERR_PTR(-EBADF);
> -	sock = tun_get_socket(file);
> +	sock = tun_get_socket(f.file);
>  	if (!IS_ERR(sock))
>  		return sock;
> -	sock = tap_get_socket(file);
> +	sock = tap_get_socket(f.file);
>  	if (IS_ERR(sock))
> -		fput(file);
> +		fdput(f);
>  	return sock;

NAK.  For the same reason why the sockfd_lookup() counterpart of that
patch is broken.  After your change there's no way for the caller
to tell whether we have bumped the refcount of file in question;
this can't possibly work.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
