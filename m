From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC] virtio-mmio: Update the device to OASIS spec version
Date: Thu, 15 Jan 2015 19:12:07 +0200
Message-ID: <20150115171207.GA30300@redhat.com>
References: <1419014284-18500-1-git-send-email-pawel.moll@arm.com>
	<20150115165101.GA29808@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20150115165101.GA29808@redhat.com>
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
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jan 15, 2015 at 06:51:01PM +0200, Michael S. Tsirkin wrote:
> Host no longer knows the alignment, so why is it needed?
> In fact, I notice that 4.3.2.3 Virtqueue Layout seems completely wrong:
> it corresponds to legacy devices, and it does not
> say what "align" is.

I created
https://issues.oasis-open.org/browse/VIRTIO-129
to track this. Can you write up a patch please?

-- 
MST
