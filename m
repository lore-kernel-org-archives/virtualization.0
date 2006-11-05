From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 1/7] paravirtualization: header and stubs =?iso-8859-15?q?for=09paravirtualizing_critical?= operations
Date: Sun, 5 Nov 2006 06:46:15 +0100
Message-ID: <200611050646.15334.ak@suse.de>
References: <20061029024504.760769000@sous-sol.org> <200611032209.40235.ak@suse.de> <1162701815.29777.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161032AbWKEFqd@vger.kernel.org>
In-Reply-To: <1162701815.29777.6.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Zachary Amsden <zach@vmware.com>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org, akpm@osdl.org
List-Id: virtualization@lists.linuxfoundation.org


> Andi, the patches work against Andrew's tree, and he's merged them in
> rc4-mm2.  There are a few warnings to clean up, but it seems basically
> sound.
> 
> At this point I our think time is better spent on beating those patches
> up, rather than going back and figuring out why they don't work in your
> tree.

My tree is basically mainline as base. Sure if you don't care about mainline
merges we can ignore it there and keep it forever in -mm* until Andrew
gets tired of it?

That's a possible strategy, but only if you want to keep it as a mm-only
toy forever.

-Andi
