From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: RE: [PATCH 1/4] staging: hv: Fix the code depending on struct
 vmbus_driver_context data order
Date: Wed, 23 Feb 2011 22:55:12 +0000
Message-ID: <A1F3067C9B68744AA19F6802BAB8FFDC060EE9@TK5EX14MBXC227.redmond.corp.microsoft.com>
References: <1298492398-16522-1-git-send-email-haiyangz@microsoft.com>
 <20110223212644.GC23766@kroah.com>
 <6E21E5352C11B742B20C142EB499E048014F2C@TK5EX14MBXC128.redmond.corp.microsoft.com>
 <20110223224829.GA7175@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110223224829.GA7175@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>, KY Srinivasan <kys@microsoft.com>
Cc: Hank Janssen <hjanssen@microsoft.com>, "Abhishek Kane (Mindtree Consulting PVT LTD)" <v-abkane@microsoft.com>, "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

> From: Greg KH [mailto:greg@kroah.com]
> The layering is almost ok, there is still one more layer here than is
> needed, and it should be removed (I already removed lots of layers that
> were not needed, just didn't get to this one.)  But the naming also
> needs to be fixed up as it is wrong from a "driver model" standpoint
> with the rest of the kernel.

So, how about rename the "struct driver_context" to "struct gen_drv_ctx"
in this patch? We can deal with the layering in next round of patches.

Thanks,

- Haiyang
