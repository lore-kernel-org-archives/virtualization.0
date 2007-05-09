From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch 2/9] lguest: the guest code
Date: Wed, 09 May 2007 21:59:17 +1000
Message-ID: <1178711957.7286.87.camel@localhost.localdomain>
References: <200705090951.l499pYBV020391@shell0.pdx.osdl.net>
	 <84144f020705090316o5e3b6d89r74638ec8e4d396d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755887AbXEIMAH@vger.kernel.org>
In-Reply-To: <84144f020705090316o5e3b6d89r74638ec8e4d396d4@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, ak@suse.de, jeremy@goop.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2007-05-09 at 13:16 +0300, Pekka Enberg wrote:
> Hi Rusty,
> 
> On 5/9/07, akpm@linux-foundation.org <akpm@linux-foundation.org> wrote:
> > +static void add_lguest_device(unsigned int index)
> > +{
> > +       struct lguest_device *new;
> > +
> > +       lguest_devices[index].status |= LGUEST_DEVICE_S_ACKNOWLEDGE;
> > +       new = kmalloc(sizeof(struct lguest_device), GFP_KERNEL);
> > +       if (!new) {
> > +               printk(KERN_EMERG "Cannot allocate lguest device %u\n", index);
> > +               lguest_devices[index].status |= LGUEST_DEVICE_S_FAILED;
> 
> [snip]
> 
> Any reason why we don't return an error here?

Hi Pekka,

	Hmm, where would the error go?

A little confused,
Rusty.
