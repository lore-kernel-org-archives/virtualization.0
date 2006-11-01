From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 1/7] paravirtualization: header and stubs for paravirtualizing critical operations
Date: Wed, 1 Nov 2006 18:27:48 +0100
Message-ID: <200611011827.49108.ak@suse.de>
References: <20061029024504.760769000@sous-sol.org> <1162376827.23462.5.camel@localhost.localdomain> <1162377928.23744.4.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1946951AbWKAR2T@vger.kernel.org>
In-Reply-To: <1162377928.23744.4.camel@laptopd505.fenrus.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, virtualization@lists.osdl.org, Chris Wright <chrisw@sous-sol.org>, akpm@osdl.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 01 November 2006 11:45, Arjan van de Ven wrote:

> this is a lot of infrastructure... do we have more than 1 user of this
> yet that wants to get merged in mainline?

AFAIK xen, vmi, lhype (and native ops).

-Andi
