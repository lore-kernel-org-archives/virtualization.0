Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2898ACDB47E
	for <virtualization@archiver.kernel.org>; Fri, 13 Oct 2023 10:28:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B90D741D9F;
	Fri, 13 Oct 2023 10:28:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B90D741D9F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UjGqXHhG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sdbF-DAhWgMo; Fri, 13 Oct 2023 10:28:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 185FF41DB2;
	Fri, 13 Oct 2023 10:28:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 185FF41DB2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2DD9C0071;
	Fri, 13 Oct 2023 10:28:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 64F3EC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Oct 2023 10:28:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3DA28405D6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Oct 2023 10:28:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3DA28405D6
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=UjGqXHhG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9j2Y_1w3jPO2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Oct 2023 10:28:46 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 28BCC400CB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Oct 2023 10:28:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 28BCC400CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697192926; x=1728728926;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to;
 bh=/ji+HuuWrqaUKnBD5fajwGqzQmBqwfwkvoSu+zCpKPw=;
 b=UjGqXHhGpsrMwzwy0cERkRyl2rC2MpyXZXtIGPg4SvB+aEO1vFxNkmRQ
 8Z04ucFst4K9LCAQSFmPL66l8hg5tu9v+bUXuzoWTXI4VJ7SOFmQNussZ
 8t2soNOVWzvddYXFfnbeQ3gGqBS+yIIf4VWEpZPYYdC22tx3VeLMU8miQ
 84Z/hhhUMeuJ4QQ2RsHNLESumhoIAPFOM2JaZt/c2W6EeoQRyP/o8a8Gg
 vTzfKJKBRSvcNxYi22iDgRggllOdPP0DwpQ78GTXpZA/6OLXBAh1N0NgC
 Z17rkrmMJ8ONhoAPqMIHhNgVNnmUIa7A56l58zSf9Rb+Y1IicDE0Ia9Yf A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="364515209"
X-IronPort-AV: E=Sophos;i="6.03,221,1694761200"; 
 d="scan'208,217";a="364515209"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2023 03:28:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="758453038"
X-IronPort-AV: E=Sophos;i="6.03,221,1694761200"; 
 d="scan'208,217";a="758453038"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.93.29.0])
 ([10.93.29.0])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2023 03:28:37 -0700
Message-ID: <840d4c6f-4150-4818-a66c-1dbe1474b4c6@intel.com>
Date: Fri, 13 Oct 2023 18:28:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH vfio 10/11] vfio/virtio: Expose admin commands over virtio
 device
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20231010140849.GL3952@nvidia.com>
 <20231010105339-mutt-send-email-mst@kernel.org>
 <e979dfa2-0733-7f0f-dd17-49ed89ef6c40@nvidia.com>
 <20231010111339-mutt-send-email-mst@kernel.org>
 <20231010155937.GN3952@nvidia.com> <ZSY9Cv5/e3nfA7ux@infradead.org>
 <20231011021454-mutt-send-email-mst@kernel.org>
 <ZSZHzs38Q3oqyn+Q@infradead.org>
 <PH0PR12MB5481336B395F38E875ED11D8DCCCA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <c75bb669-76fe-ef12-817e-2a8b5f0b317b@intel.com>
 <20231012132749.GK3952@nvidia.com>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <20231012132749.GK3952@nvidia.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Leon Romanovsky <leonro@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
 Maor Gottlieb <maorg@nvidia.com>
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
Content-Type: multipart/mixed; boundary="===============6032283145338888533=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is a multi-part message in MIME format.
--===============6032283145338888533==
Content-Type: multipart/alternative;
 boundary="------------NqORYrha0EqGVvEB2iIKOt8n"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------NqORYrha0EqGVvEB2iIKOt8n
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/12/2023 9:27 PM, Jason Gunthorpe wrote:
> On Thu, Oct 12, 2023 at 06:29:47PM +0800, Zhu, Lingshan wrote:
>
>> sorry for the late reply, we have discussed this for weeks in virtio mailing
>> list. I have proposed a live migration solution which is a config space solution.
> I'm sorry that can't be a serious proposal - config space can't do
> DMA, it is not suitable.
config space only controls the live migration process and config the 
related facilities.
We don't use config space to transfer data.

The new added registers work like queue_enable or features.

For example, we use DMA to report dirty pages and MMIO to fetch the 
dirty data.

I remember in another thread you said:"you can't use DMA for any 
migration flows"

And I agree to that statement, so we use config space registers to 
control the flow.

Thanks,
Zhu Lingshan
>
> Jason

--------------NqORYrha0EqGVvEB2iIKOt8n
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <font face="monospace"><br>
      <br>
    </font>
    <div class="moz-cite-prefix"><font face="monospace">On 10/12/2023
        9:27 PM, Jason Gunthorpe wrote:<br>
      </font></div>
    <blockquote type="cite" cite="mid:20231012132749.GK3952@nvidia.com">
      <pre class="moz-quote-pre" wrap="">On Thu, Oct 12, 2023 at 06:29:47PM +0800, Zhu, Lingshan wrote:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">sorry for the late reply, we have discussed this for weeks in virtio mailing
list. I have proposed a live migration solution which is a config space solution.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I'm sorry that can't be a serious proposal - config space can't do
DMA, it is not suitable.</pre>
    </blockquote>
    <font face="monospace">config space only controls the live migration
      process and config the related facilities.<br>
      We don't use config space to transfer data.<br>
      <br>
      The new added registers work like queue_enable or features.<br>
      <br>
      For example, we use DMA to report dirty pages and MMIO to fetch
      the dirty data.<br>
      <br>
      I remember in another thread you said:"<span
      style="white-space: pre-wrap">you can't use DMA for any migration flows</span>"<br>
      <br>
      And I agree to that statement, so we use config space registers to
      control the flow.<br>
      <br>
      Thanks,<br>
      Zhu Lingshan<br>
    </font>
    <blockquote type="cite" cite="mid:20231012132749.GK3952@nvidia.com">
      <pre class="moz-quote-pre" wrap="">

Jason
</pre>
    </blockquote>
    <font face="monospace"><br>
    </font>
  </body>
</html>

--------------NqORYrha0EqGVvEB2iIKOt8n--

--===============6032283145338888533==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6032283145338888533==--
