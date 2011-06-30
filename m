From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 4/4] xen/netback: Add module alias for autoloading
Date: Thu, 30 Jun 2011 11:19:51 -0700 (PDT)
Message-ID: <20110630.111951.1084304206576075172.davem__12679.9099416987$1309458063$gmane$org@davemloft.net>
References: <20110629124132.GD31038@wavehammer.waldi.eu.org>
	<20110630163954.GE5771@dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20110630163954.GE5771@dumpdata.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: konrad.wilk@oracle.com
Cc: axboe@kernel.dk, xen-devel@lists.xensource.com, waldi@debian.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Date: Thu, 30 Jun 2011 12:39:54 -0400

> On Wed, Jun 29, 2011 at 02:41:32PM +0200, Bastian Blank wrote:
>> Add xen-backend:vif module alias to the xen-netback module. This allows
>> automatic loading of the module.
> 
> Dave,
> 
> Could you queue this up for 3.1 please? I've the other two patches in my
> tree for 3.1 and the block patch ready for Jens.

Done.
