From: Christoph Hellwig <hch@lst.de>
Subject: Re: 4.14: WARNING: CPU: 4 PID: 2895 at block/blk-mq.c:1144 with
	virtio-blk (also 4.12 stable)
Date: Thu, 23 Nov 2017 15:08:55 +0100
Message-ID: <20171123140855.GA29145__34492.7988517613$1511446168$gmane$org@lst.de>
References: <5c9f2228-0a8b-8225-7038-e6cb3f31ca0b@kernel.dk>
	<2e44dbd3-2f90-c267-560c-91d1d4b0e892@de.ibm.com>
	<823b9dd5-7781-5a72-03ff-bc931433fc19@kernel.dk>
	<bd928410-4d38-603e-00c9-4c4db20d8e86@de.ibm.com>
	<15f232d2-2aaa-df7c-57e8-2f710e051e84@de.ibm.com>
	<c8bd769e-9742-205d-11b0-469428a8579c@de.ibm.com>
	<b7b3cf4b-837e-f9ba-61c0-4f9ddd8b9a95@kernel.dk>
	<055f040d-3f9a-a8fd-e8e2-326c6b9094a1@kernel.dk>
	<1aeecf2e-a68e-4c18-5912-2473f457e6ea@de.ibm.com>
	<20171123140208.GA28914@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20171123140208.GA28914@lst.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, "mst@redhat.com" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Bart Van Assche <Bart.VanAssche@wdc.com>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

Ok, it helps to make sure we're actually doing I/O from the CPU,
I've reproduced it now.
