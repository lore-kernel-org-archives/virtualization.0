From: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.25-rc5-mm1 (paravirt/vsmp/no PCI)
Date: Wed, 12 Mar 2008 08:14:25 +0100
Message-ID: <20080312071425.GA21891@elte.hu>
References: <20080311011434.ad8c8d7d.akpm@linux-foundation.org> <20080311100955.ca113f90.randy.dunlap@oracle.com> <47D6CD04.8060303@goop.org> <20080312001040.GA6434@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752843AbYCLHPn@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080312001040.GA6434@localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Randy Dunlap <randy.dunlap@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <glommer@gmail.com>, shai@scalex86.org
List-Id: virtualization@lists.linuxfoundation.org


* Ravikiran G Thirumalai <kiran@scalex86.org> wrote:

> Would anyone have objection to have PARAVIRT depend on PCI, since the 
> vsmp paravirt bits depend on PCI cfg space to determine if the system 
> is vsmp?  If not, this patch would suffice.

hm, that's not a good idea - there's nothing in lguest, Xen and even KVM 
that is inherently tied to PCI.

	Ingo
