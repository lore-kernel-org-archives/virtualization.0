From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 1/5] Skip timer works.patch
Date: Thu, 16 Nov 2006 08:02:04 +0100
Message-ID: <200611160802.05131.ak@suse.de>
References: <200610200009.k9K09MrS027558@zach-dev.vmware.com>
	<20061116032702.GH9579@bingen.suse.de>
	<20061115210630.94bf8824.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20061115210630.94bf8824.akpm@osdl.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org


> =

> wtf?  =


I don't know. I applied all, except 3 non paravirt related patches you sent
me.

> How come patches leave here in working order and keep arriving broken? =


Maybe it's my toolchain (gcc 4.0) or my config (defconfig)
But looking at the asm() I'm not sure it ever worked anywhere.

-Andi
