From: Jes Sorensen <jes@sgi.com>
Subject: Re: [PATCH 04/15] ia64/pv_ops: introduce pv_info which describes
	some random info.
Date: Tue, 22 Apr 2008 15:55:54 +0200
Message-ID: <480DEE6A.8050408__34116.7268612937$1208872759$gmane$org@sgi.com>
References: <1207716548202-git-send-email-yamahata@valinux.co.jp>
	<12077165491881-git-send-email-yamahata@valinux.co.jp>
	<yq04p9ul05i.fsf@jaguar.mkp.net>
	<20080422100219.GG28863%yamahata@valinux.co.jp>
	<480DBFD2.9060600@sgi.com>
	<10EA09EFD8728347A513008B6B0DA77A031466E7@pdsmsx411.ccr.corp.intel.com>
	<480DCC3A.1010007@sgi.com>
	<10EA09EFD8728347A513008B6B0DA77A0314671D@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <10EA09EFD8728347A513008B6B0DA77A0314671D@pdsmsx411.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Dong, Eddie" <eddie.dong@intel.com>
Cc: Isaku Yamahata <yamahata@valinux.co.jp>, xen-ia64-devel@lists.xensource.com, linux-ia64@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Dong, Eddie wrote:
> My understanding is that code such as IVT table are well tuned and you
> are really 
> difficult to pursuade people to replace those privilege resource access
> instruction
> to use vdso or something equalvalent such as mov GRx=CRy.  For those C
> code
> previlige resource access, like Isaku mentioned, we need to consider
> native too.

Hi Eddie,

I think binary patching of the ivt makes a lot of sense, I am certainly
not opposed to that. I was more thinking in terms of calls out of the
regular C code.

Cheers,
Jes
