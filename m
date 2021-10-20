Return-Path: <SRS0=Bv1r=PI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D8BC433EF
	for <virtualization@archiver.kernel.org>; Wed, 20 Oct 2021 10:38:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE21260FD9
	for <virtualization@archiver.kernel.org>; Wed, 20 Oct 2021 10:38:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EE21260FD9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A13E04039B;
	Wed, 20 Oct 2021 10:38:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LUQtsEI5ufLh; Wed, 20 Oct 2021 10:38:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0BA7840116;
	Wed, 20 Oct 2021 10:38:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D0E9AC0011;
	Wed, 20 Oct 2021 10:38:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5DC7BC000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 10:38:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 467AF83B14
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 10:38:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=axis.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zdBaz2KIri-w
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 10:38:53 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8F34A83947
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 10:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis.com; q=dns/txt; s=axis-central1; t=1634726331;
 x=1666262331; h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Y2adYmK2ohxodX6Ld8DWVNGEgFwqUg/XOlnsfsiGzbk=;
 b=BRiG3G1UqovFmC/LTAbZ4XP0eFejUKfAPU/vEOIu+4g6gL8hUz/agT7y
 3EHrmlQ11DZ/hpMmBYLz5frLTdBsFw3Ve7aisrF2CGF0Q7FiX6xsgVe9g
 oe2RBvlApraY+TO7m1NvUu0bvPalpZ0favVz7xXPwvTTxhSDNmfdph9Pf
 T3t2DPh/fJatbzqGssmaH59zo8HUBMBBA2fzCLkd10qNDLn9TcLRSZWd+
 APEqrs0Li5zp15h4XSn51U957+Rt1BWQIITtP5YkAJ+P7WwOFSAksckyo
 ip9BHTxzlG/s0pzr4V+kr61h/7IKo+qK/RB8B+xfQE+MN5CAmGL1Ly0oH g==;
Date: Wed, 20 Oct 2021 12:38:49 +0200
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] i2c: virtio: fix completion handling
Message-ID: <20211020103849.GA9985@axis.com>
References: <20211019074647.19061-1-vincent.whitchurch@axis.com>
 <20211019074647.19061-3-vincent.whitchurch@axis.com>
 <20211019082211.ngkkkxlfcrsvfaxg@vireshk-i7>
 <81ea2661-20f8-8836-5311-7f2ed4a1781f@intel.com>
 <20211020091721.7kcihpevzf7h4d62@vireshk-i7>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211020091721.7kcihpevzf7h4d62@vireshk-i7>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, "wsa@kernel.org" <wsa@kernel.org>,
 kernel <kernel@axis.com>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
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

On Wed, Oct 20, 2021 at 11:17:21AM +0200, Viresh Kumar wrote:
> On 20-10-21, 16:54, Jie Deng wrote:
> > 
> > On 2021/10/19 16:22, Viresh Kumar wrote:
> > > On 19-10-21, 09:46, Vincent Whitchurch wrote:
> > > >   static void virtio_i2c_msg_done(struct virtqueue *vq)
> > > >   {
> > > > -	struct virtio_i2c *vi = vq->vdev->priv;
> > > > +	struct virtio_i2c_req *req;
> > > > +	unsigned int len;
> > > > -	complete(&vi->completion);
> > > > +	while ((req = virtqueue_get_buf(vq, &len)))
> > > > +		complete(&req->completion);
> > > Instead of adding a completion for each request and using only the
> > > last one, maybe we can do this instead here:
> > > 
> > > 	while ((req = virtqueue_get_buf(vq, &len))) {
> > >                  if (req->out_hdr.flags == cpu_to_le32(VIRTIO_I2C_FLAGS_FAIL_NEXT))
> > 
> > 
> > Is this for the last one check ? For the last one, this bit should be
> > cleared, right ?
> 
> Oops, you are right. This should be `!=` instead. Thanks.

I don't quite understand how that would be safe since
virtqueue_add_sgs() can fail after a few iterations and all queued
request buffers can have FAIL_NEXT set.  In such a case, we would end up
waiting forever with your proposed change, wouldn't we?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
