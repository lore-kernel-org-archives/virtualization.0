From: Roland McGrath <roland@redhat.com>
Subject: Re: [patch 1/2] Relocate VDSO ELF headers to match mapped location with COMPAT_VDSO
Date: Thu,  5 Apr 2007 01:58:40 -0700 (PDT)
Message-ID: <20070405085840.2AFD8180055@magilla.sf.frob.com>
References: <4614B0DB.7040003@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964852AbXDEI6r@vger.kernel.org>
In-Reply-To: Jeremy Fitzhardinge's message of  Thursday, 5 April 2007 01:18:35 -0700 <4614B0DB.7040003@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Jan Beulich <jbeulich@novell.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>, Zachary Amsden <zach@vmware.com>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: virtualization@lists.linuxfoundation.org

Don't change sh_addr in sections with (sh_flags & SHF_ALLOC) == 0.  Also,
I'd concur with Jan's suggestion about paranoia warnings for unexpected
DT_* types (and for unexpected st_shndx >= SHN_LORESERVE).

Otherwise, looks ok to me.


Thanks,
Roland
