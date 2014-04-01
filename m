From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] virtio-blk: make the queue depth the max supportable by
	the hypervisor
Date: Mon, 31 Mar 2014 22:27:08 -0400
Message-ID: <20140401022708.GD4911__5365.65983570672$1396319385$gmane$org@thunk.org>
References: <1394841445-16142-1-git-send-email-venkateshs@google.com>
	<1394854471-25700-1-git-send-email-tytso@mit.edu>
	<87siqhu048.fsf@rustcorp.com.au> <20140317054053.GF14162@thunk.org>
	<871txysnw2.fsf@rustcorp.com.au>
	<CAHdzE-_cAndCNhBM1N0RpjQDhoh3Snas-eza4rYN33Rf69PXyw@mail.gmail.com>
	<CAHdzE--CvgsPOFQ5OFRoe7L+kkJ0J3eRWR0JQv34i4AmNDBJug@mail.gmail.com>
	<87ha6fowh9.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87ha6fowh9.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, Linux Kernel Developers List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Mar 31, 2014 at 02:22:50PM +1030, Rusty Russell wrote:
> 
> It's head of my virtio-next tree.

Hey Rusty,

While we have your attention --- what's your opinion about adding TRIM
support to virtio-blk.  I understand that you're starting an OASIS
standardization process for virtio --- what does that mean vis-a-vis a
patch to plumb discard support through virtio-blk?

Thanks!

						- Ted
