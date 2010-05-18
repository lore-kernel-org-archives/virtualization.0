From: Jens Axboe <qemu@kernel.dk>
Subject: Re: [PATCH RFC] virtio_blk: Use blk-iopoll for host->guest notify
Date: Tue, 18 May 2010 15:07:13 +0200
Message-ID: <20100518130712.GA25951__33413.622986018$1274188153$gmane$org@kernel.dk>
References: <1273870057-4287-1-git-send-email-stefanha@linux.vnet.ibm.com>
	<201005141730.57158.iggy@theiggy.com>
	<20100518080705.GA2467@stefan-thinkpad.transitives.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100518080705.GA2467@stefan-thinkpad.transitives.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, May 18 2010, Stefan Hajnoczi wrote:
> On Fri, May 14, 2010 at 05:30:56PM -0500, Brian Jackson wrote:
> > Any preliminary numbers? latency, throughput, cpu use? What about comparing 
> > different "weights"?
> 
> I am running benchmarks and will report results when they are in.

I'm very interested as well, I have been hoping for some more adoption
of this. I have mptsas and mpt2sas patches pending as well.

I have not done enough and fully exhaustive weight analysis, so note me
down for wanting such an analysis on virtio_blk as well.

-- 
Jens Axboe
