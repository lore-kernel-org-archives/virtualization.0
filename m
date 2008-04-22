From: "Dong, Eddie" <eddie.dong@intel.com>
Subject: RE: [PATCH 04/15] ia64/pv_ops: introduce pv_info which describes some
	random info.
Date: Tue, 22 Apr 2008 18:41:28 +0800
Message-ID: <10EA09EFD8728347A513008B6B0DA77A031466E7__42199.0879382522$1208861042$gmane$org@pdsmsx411.ccr.corp.intel.com>
References: <1207716548202-git-send-email-yamahata@valinux.co.jp>
	<12077165491881-git-send-email-yamahata@valinux.co.jp>
	<yq04p9ul05i.fsf@jaguar.mkp.net>
	<20080422100219.GG28863%yamahata@valinux.co.jp>
	<480DBFD2.9060600@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <480DBFD2.9060600@sgi.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jes Sorensen <jes@sgi.com>, Isaku Yamahata <yamahata@valinux.co.jp>
Cc: xen-ia64-devel@lists.xensource.com, linux-ia64@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


> 
> Rather than making these binary patches, why not make them fast
> syscalls and using a vdso page. Some of the priviledged instructions
> are simply reads and we could have that information in a read-only
> data page, so there is no need to do a context switch at all. Others
> could benefit from a fast system call that doesn't do a full context
> switch. 

The issue is we don't want to change Linux code a lot, otherwise it
won't be accepted. If we use same logic with original Linux,
but it is using indirect function call now, binary patching could help
in performance.

> 
> It would be nice if we could come up with a generic implementation for
> such a vdso style interface that could be shared between
> xen/kvm/lguest. 
> 
Introducing a new mechanism to use it to replace Linux code to use them
is another different story.

Eddie
