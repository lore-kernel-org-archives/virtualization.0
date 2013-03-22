From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 05/22] virtio: add support for 64 bit features.
Date: Fri, 22 Mar 2013 10:15:37 +0100
Message-ID: <20130322101537.02cb580a@gondolin>
References: <1363854584-25795-1-git-send-email-rusty@rustcorp.com.au>
	<1363854584-25795-6-git-send-email-rusty@rustcorp.com.au>
	<20130321110614.24c6ed08@gondolin> <87620kfebm.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87620kfebm.fsf@rustcorp.com.au>
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
Cc: Brian Swetland <swetland@google.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Pawel Moll <pawel.moll@arm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 22 Mar 2013 11:20:05 +1030
Rusty Russell <rusty@rustcorp.com.au> wrote:

> Cornelia Huck <cornelia.huck@de.ibm.com> writes:
> > On Thu, 21 Mar 2013 18:59:26 +1030
> > Rusty Russell <rusty@rustcorp.com.au> wrote:
> >
> >> Change the u32 to a u64, and make sure to use 1ULL everywhere!
> >
> > And a not-even-compiled change for virtio_ccw as well:
> 
> Thanks, applied that too.
> 
> BTW, this will all be in my virtio-pci-new-layout branch on
> git.kernel.org once I've processed all this feedback.

I'll give it a run then once your branch is ready.

> 
> Thanks,
> Rusty.
> 
