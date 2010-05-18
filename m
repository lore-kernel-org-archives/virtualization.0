From: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC] virtio_blk: Use blk-iopoll for host->guest notify
Date: Tue, 18 May 2010 09:07:06 +0100
Message-ID: <20100518080705.GA2467__1406.29425081915$1274170128$gmane$org@stefan-thinkpad.transitives.com>
References: <1273870057-4287-1-git-send-email-stefanha@linux.vnet.ibm.com>
	<201005141730.57158.iggy@theiggy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201005141730.57158.iggy@theiggy.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Brian Jackson <iggy@theiggy.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, May 14, 2010 at 05:30:56PM -0500, Brian Jackson wrote:
> Any preliminary numbers? latency, throughput, cpu use? What about comparing 
> different "weights"?

I am running benchmarks and will report results when they are in.

Stefan
