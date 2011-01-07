From: Hank Janssen <hjanssen@microsoft.com>
Subject: RE: [PATCH 1/1] staging: hv: Removed unneeded call to
 netif_stop_queue() in hv_netvsc
Date: Fri, 7 Jan 2011 17:48:11 +0000
Message-ID: <8AFC7968D54FB448A30D8F38F259C56233F397CF@TK5EX14MBXC114.redmond.corp.microsoft.com>
References: <1294421139-18657-1-git-send-email-hjanssen@microsoft.com>
 <20110107173139.GA12343@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110107173139.GA12343@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, "Abhishek Kane (Mindtree Consulting PVT LTD)" <v-abkane@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Greg KH [mailto:gregkh@suse.de]
> Sent: Friday, January 07, 2011 9:32 AM
> 
> What kernel is this needed for, .37?  .38?  older than .37?
> 
> thanks,
> 
> greg k-h

This is needed for kernels 2.6.37 and newer.

Btw, I have not seen KVP patches that where submitted in linux next yet.
I have not seen any other requests for changes to them, is there anything else needed for acceptance?

Thanks,

Hank.
