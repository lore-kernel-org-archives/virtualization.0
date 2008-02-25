From: "Dong, Eddie" <eddie.dong@intel.com>
Subject: RE: [kvm-ia64-devel] [PATCH 13/28] ia64/xen: introduce xenhypercall
	routines necessary for domU.
Date: Tue, 26 Feb 2008 02:36:51 +0800
Message-ID: <10EA09EFD8728347A513008B6B0DA77A02CFD330__43982.1070329801$1203965809$gmane$org@pdsmsx411.ccr.corp.intel.com>
References: <20080221091731.641745000@ls.local.valinux.co.jp><20080221091902.716789000@ls.local.valinux.co.jp><47BE0D7E.7080301@goop.org>
	<20080222035457.GB2406%yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <20080222035457.GB2406%yamahata@valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Isaku Yamahata <yamahata@valinux.co.jp>, Jeremy Fitzhardinge <jeremy@goop.org>
Cc: xen-ia64-devel@lists.xensource.com, linux-ia64@vger.kernel.org, kvm-ia64-devel@lists.sourceforge.net, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


> IA64 pv_ops frame work doesn't exist yet so that xen code does
> in order to boot on both native and xen for now.
> I expect those check will be eliminated during developing ia64 pv_ops.

Qing He & I am working on the pv_ops framework, hopefully we can get
a draft soon :)

Eddie
