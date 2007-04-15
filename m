From: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH 10/28] i386: map enough initial memory to create lowmem mappings
Date: Sun, 15 Apr 2007 12:17:24 +0200
Message-ID: <jeejmmkkln.fsf@sykes.suse.de>
References: <20070414204154.871250608@goop.org>
	<20070414204924.125386443@goop.org> <46214FD3.3080400@zytor.com>
	<Pine.LNX.4.61.0704151145410.15892@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752652AbXDOKRt@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0704151145410.15892@yvahk01.tjqt.qr> (Jan
	Engelhardt's message of "Sun, 15 Apr 2007 11:46:12 +0200 (MEST)")
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Jeremy Fitzhardinge <jeremy@goop.org>, Andi Kleen <ak@suse.de>, Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, Zachary Amsden <zach@vmware.com>, Chris Wright <chrisw@sous-sol.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Jan Engelhardt <jengelh@linux01.gwdg.de> writes:

> LOW_PAGES =3D (0x100000000ULL - __PAGE_OFFSET) >> PAGE_SHIT_asm

The assembler does not now anything about ULL.

Andreas.

--=20
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstra=DFe 5, 90409 N=FCrnberg, Germany
PGP key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
