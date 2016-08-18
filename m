From: Ed Cashin <ed.cashin@acm.org>
Subject: Re: [PATCH 06/15] genhd: Add return code to device_add_disk
Date: Wed, 17 Aug 2016 21:09:37 -0400
Message-ID: <57B50AD1.6010403__33992.7253000953$1471482998$gmane$org@acm.org>
References: <1471418115-3654-1-git-send-email-famz@redhat.com>
	<1471418115-3654-7-git-send-email-famz@redhat.com>
	<20160817104914.37087cb3.cornelia.huck@de.ibm.com>
	<20160817084823.GB19326@al.usersys.redhat.com>
	<20160817110645.45370f57.cornelia.huck@de.ibm.com>
	<20160817091422.GE19326@al.usersys.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160817091422.GE19326@al.usersys.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Fam Zheng <famz@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, Minchan Kim <minchan@kernel.org>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-mtd@lists.infradead.org, Brian Norris <computersforpeace@gmail.com>, linuxppc-dev@lists.ozlabs.org, David Woodhouse <dwmw2@infradead.org>, Nitin Gupta <ngupta@vflare.org>
List-Id: virtualization@lists.linuxfoundation.org

On 08/17/2016 05:14 AM, Fam Zheng wrote:
...
> Of course, the plan is to write patches on top. I'm not cleaning up anything
> here because I'm concerned callers may double free (and I didn't look hard into
> that).

Aside from Huck's concerns, the changes looked OK from aoe's perspective.

-- 
   Ed
