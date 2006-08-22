From: Andi Kleen <ak@muc.de>
Subject: Re: [PATCH] paravirt.h
Date: Tue, 22 Aug 2006 15:50:57 +0200
Message-ID: <200608221550.57603.ak@muc.de>
References: <1155202505.18420.5.camel@localhost.localdomain> <1156254965.27114.17.camel@localhost.localdomain> <1156254322.2976.55.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932248AbWHVNvN@vger.kernel.org>
In-Reply-To: <1156254322.2976.55.camel@laptopd505.fenrus.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: virtualization@lists.osdl.org
Cc: Arjan van de Ven <arjan@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org


> this would need a "const after boot" section; which is really not hard
> to make and probably useful for a lot more things.... todo++

except for anything that needs tlb entries in user space. And it only gives you
false sense of security. --todo

-Andi
