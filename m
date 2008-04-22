From: Jes Sorensen <jes@sgi.com>
Subject: Re: [PATCH 04/15] ia64/pv_ops: introduce pv_info which describes some
	random info.
Date: 22 Apr 2008 05:16:41 -0400
Message-ID: <yq04p9ul05i.fsf__40888.6856436313$1208855921$gmane$org@jaguar.mkp.net>
References: <1207716548202-git-send-email-yamahata@valinux.co.jp>
	<12077165491881-git-send-email-yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <12077165491881-git-send-email-yamahata@valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Isaku Yamahata <yamahata@valinux.co.jp>
Cc: eddie.dong@intel.com, xen-ia64-devel@lists.xensource.com, linux-ia64@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

>>>>> "Isaku" == Isaku Yamahata <yamahata@valinux.co.jp> writes:

Isaku> introduce pv_info which describes some randome info about
Isaku> underlying execution environment.

Hi Isaku,

I am missing some of the patches in this series for some reason.
However, I'd like to open the discussion and ask why you are
implementing the pv-ops seperately instead of adding them to the
machine vectors and using the machine vector interface to handle the
direct implementation?

It seems to me that pvops really are just an advanced level of the
ia64 machine vectors and building on top of the interface we already
have would make it easier to support different machine types through
pvops.

Cheers,
Jes
