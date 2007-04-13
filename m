From: Keir Fraser <keir@xensource.com>
Subject: Re: [PATCH 0/4] i386 - pte update optimizations
Date: Fri, 13 Apr 2007 12:31:13 +0100
Message-ID: <C2452891.D417%keir@xensource.com>
References: <p738xcw7942.fsf@bingen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753553AbXDMLbc@vger.kernel.org>
In-Reply-To: <p738xcw7942.fsf@bingen.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Zachary Amsden <zach@vmware.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@osdl.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Chris Wright <chrisw@sous-sol.org>, David Rientjes <rientjes@google.com>, Hugh Dickins <hugh@veritas.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On 13/4/07 13:27, "Andi Kleen" <andi@firstfloor.org> wrote:

>> LOCKed instruction suck really badly on the netburst microarchitecture (like
>> factor of 10x, or not far off). I think it's probably because of their side
>> effect of serialising memory accesses, causing horrible pipeline stalls.
> 
> Unfortunately they tend to be HyperThreaded usually (except for early ones
> and Celerons) and need the LOCK anyways.

Fair point, although quite a few people disable HT.

 -- Keir
