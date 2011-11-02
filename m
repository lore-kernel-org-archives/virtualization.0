From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Additional virtio-mmio spec changes
Date: Wed, 02 Nov 2011 11:51:02 +1030
Message-ID: <87wrbjtj41.fsf__23944.7095584639$1320208524$gmane$org@rustcorp.com.au>
References: <1320152499.3287.197.camel@hornet.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1320152499.3287.197.camel@hornet.cambridge.arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Pawel Moll <pawel.moll@arm.com>
Cc: Peter Maydell <Peter.Maydell@ARM.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 01 Nov 2011 13:01:39 +0000, Pawel Moll <pawel.moll@arm.com> wrote:
> Hi Rusty,
> 
> Peter (on Cc) got the qemu implementation up and running (thanks!) and
> provided some useful feedback regarding the spec. To make the long story
> short, this is what came out of the discussion (feel free to correct me
> at any point, Peter ;-):

OK, I applied them manually.  One of the pains of using LyX is that you
need to turn change tracking on before making changes (I really like to
produce change-tracking versions of new spec releases).

> Of course those changes are not critical so can easily wait till the
> next release. Peter also mentioned that he didn't like the "Num" in
> "QueueNum" register name and would rather see it called "QueueSize". I
> have no strong opinions either way and can provide patches to both the
> spec and the driver (and header) to change it. Any thoughts?

Num isn't great, but Size might be misleading.  I'd leave it...

Thanks,
Rusty.
