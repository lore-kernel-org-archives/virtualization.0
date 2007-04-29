From: Roland McGrath <roland@redhat.com>
Subject: Re: [patch 03/32] xen: Add nosegneg capability to the vsyscall page notes
Date: Sun, 29 Apr 2007 12:08:29 -0700 (PDT)
Message-ID: <20070429190830.0CF571801A4@magilla.sf.frob.com>
References: <20070429172910.877994000@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754464AbXD2TIj@vger.kernel.org>
In-Reply-To: Jeremy Fitzhardinge's message of  Sunday, 29 April 2007 10:28:38 -0700 <20070429172910.877994000@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, Ian Pratt <ian.pratt@xensource.com>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>, Zachary Amsden <zach@vmware.com>, Ulrich Drepper <drepper@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

I wouldn't add that macro to asm/elf.h.  There is nothing magical or
standard about that number.


Thanks,
Roland
