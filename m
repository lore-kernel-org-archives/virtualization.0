From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 00/02] virtio: Virtio platform driver
Date: Wed, 16 Mar 2011 14:16:13 +1030
Message-ID: <87d3lriv7e.fsf__7462.00891812823$1300249948$gmane$org@rustcorp.com.au>
References: <20110310070541.27327.52089.sendpatchset@t400s>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20110310070541.27327.52089.sendpatchset@t400s>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, Magnus Damm <magnus.damm@gmail.com>, mst@redhat.com, linux-sh@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 10 Mar 2011 16:05:41 +0900, Magnus Damm <magnus.damm@gmail.com> wrote:
> virtio: Virtio platform driver
> 
> [PATCH 01/02] virtio: Break out lguest virtio code to virtio_lguest.c
> [PATCH 02/02] virtio: Add virtio platform driver

I have no problem with these patches, but it's just churn until we see
your actual drivers.

The S/390 devs might be interested, as their bus is very similar too...

Cheers,
Rusty.
