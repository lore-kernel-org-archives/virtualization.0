From: Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH] Staging: hv: vmbus: Show the modalias in
 /sys/bus/vmbus/devices/*/
Date: Fri, 2 Sep 2011 18:38:20 +0200
Message-ID: <20110902163820.GA25353@aepfle.de>
References: <20110902162556.GA25073@aepfle.de>
 <20110902163550.GA5508@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110902163550.GA5508@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Sep 02, Greg KH wrote:

> On Fri, Sep 02, 2011 at 06:25:56PM +0200, Olaf Hering wrote:

> > +#define VMBUS_ALIAS_LEN ((sizeof((struct hv_vmbus_device_id *)0)->guid) * 2)

> > +	char alias_name[VMBUS_ALIAS_LEN + 1];
> 
> Is that too big to put on the stack?  64 bytes, right?  Hm, maybe not.

16 * 2 + 1 = 33 bytes.

Olaf
