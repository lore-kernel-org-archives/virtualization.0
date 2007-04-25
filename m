From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 09/25] xen: Account for time stolen by Xen
Date: Wed, 25 Apr 2007 11:40:53 -0700
Message-ID: <462FA0B5.9000604@goop.org>
References: <20070423215638.563901986@goop.org> <200704251115.49966.ak@suse.de> <462F9A4E.5050905@goop.org> <200704252015.06269.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S2992883AbXDYSkV@vger.kernel.org>
In-Reply-To: <200704252015.06269.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, john stultz <johnstul@us.ibm.com>, Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
> Then the barrier shouldn't be needed at all? 
>   

We still need to prevent compiler reordering.

> Anyways needs comments
>   

Yep.

    J
