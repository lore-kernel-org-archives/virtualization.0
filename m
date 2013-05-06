From: Asias He <asias@redhat.com>
Subject: Re: [PATCH 0/3] vhost cleanups and separate module
Date: Mon, 6 May 2013 16:15:39 +0800
Message-ID: <20130506081538.GA3389@hj.localdomain>
References: <1367559269-8325-1-git-send-email-asias@redhat.com>
	<87sj20prhj.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87sj20prhj.fsf@rustcorp.com.au>
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
Cc: virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Hello Rusty, 

On Mon, May 06, 2013 at 03:41:36PM +0930, Rusty Russell wrote:
> Asias He <asias@redhat.com> writes:
> > Asias He (3):
> >   vhost: Remove vhost_enable_zcopy in vhost.h
> >   vhost: Move VHOST_NET_FEATURES to net.c
> >   vhost: Make vhost a separate module
> 
> I like these cleanups, MST pleasee apply.
> 
> I have some other cleanups which are on hold for the moment pending
> MST's vhost_net simplification.  MST, how's that going?

Do you mean patches in your rusty/vringh branch? I want to do the frame
assumption conversion for vhost-scsi on top of the vringh series.

> Thanks,
> Rusty.

-- 
Asias
