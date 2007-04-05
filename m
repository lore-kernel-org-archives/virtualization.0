From: Christoph Lameter <clameter@sgi.com>
Subject: Re: [patch 07/20] Allow paravirt backend to choose kernel PMD sharing
Date: Wed, 4 Apr 2007 17:30:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704041729300.22161@schroedinger.engr.sgi.com>
References: <20070404191151.009821039@goop.org> <20070404191205.392155702@goop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932184AbXDEAaj@vger.kernel.org>
In-Reply-To: <20070404191205.392155702@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, William Lee Irwin III <wli@holomorphy.com>, Zachary Amsden <zach@vmware.com>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Acked-by: Christoph Lameter <clameter@sgi.com>

for all thats worth since I am not a i386 specialist.

How much of the issues with page struct sharing between slab and arch code 
does this address?
