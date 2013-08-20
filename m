From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [Xen-devel] [PATCH] xen: initialize xen panic handler for PVHVM
Date: Tue, 20 Aug 2013 15:39:15 -0400
Message-ID: <20130820193915.GJ12037@phenom.dumpdata.com>
References: <1376640656-32381-1-git-send-email-vaughan.cao@oracle.com>
	<20130816124327.GC10190@konrad-lan.dumpdata.com>
	<5211B8C2.1010702@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5211B8C2.1010702@oracle.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Joe Jin <joe.jin@oracle.com>
Cc: jeremy@goop.org, xen-devel@lists.xensource.com, Vaughan Cao <vaughan.cao@oracle.com>, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, hpa@zytor.com, tglx@linutronix.de
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Aug 19, 2013 at 02:18:42PM +0800, Joe Jin wrote:
> On 08/16/13 20:43, Konrad Rzeszutek Wilk wrote:
> > Could you tell me what has been happening without this patch?
> 
> Without this patch, Xen would not get pvhvm crash event, any config for
> on_crash in guest configure file will not be triggered.

applied for 3.12
> 
> Thanks,
> Joe
> 
