From: "Pekka Enberg" <penberg@cs.helsinki.fi>
Subject: Re: [patch 2/9] lguest: the guest code
Date: Wed, 9 May 2007 13:16:23 +0300
Message-ID: <84144f020705090316o5e3b6d89r74638ec8e4d396d4@mail.gmail.com>
References: <200705090951.l499pYBV020391@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755757AbXEIKQf@vger.kernel.org>
In-Reply-To: <200705090951.l499pYBV020391@shell0.pdx.osdl.net>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, rusty@rustcorp.com.au, ak@suse.de, jeremy@goop.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Rusty,

On 5/9/07, akpm@linux-foundation.org <akpm@linux-foundation.org> wrote:
> +static void add_lguest_device(unsigned int index)
> +{
> +       struct lguest_device *new;
> +
> +       lguest_devices[index].status |= LGUEST_DEVICE_S_ACKNOWLEDGE;
> +       new = kmalloc(sizeof(struct lguest_device), GFP_KERNEL);
> +       if (!new) {
> +               printk(KERN_EMERG "Cannot allocate lguest device %u\n", index);
> +               lguest_devices[index].status |= LGUEST_DEVICE_S_FAILED;

[snip]

Any reason why we don't return an error here?
