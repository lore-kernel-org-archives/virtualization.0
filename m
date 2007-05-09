From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [patch 7/9] lguest: the net driver
Date: Wed, 9 May 2007 14:42:11 +0200
Message-ID: <20070509124211.GG17482@one.firstfloor.org>
References: <200705090951.l499pdOr020406@shell0.pdx.osdl.net> <4641BE65.3030807@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757500AbXEIMmY@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4641BE65.3030807@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: akpm@linux-foundation.org, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, ak@suse.de, jmorris@namei.org
List-Id: virtualization@lists.linuxfoundation.org

> __pa() should not be used in any driver.

Besides that was always not supposed to work. RELOC_HIDE or __pa_symbol.

-Andi
