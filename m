From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/4] virtio_blk: deprecate the 1024-byte ID field.
Date: Tue, 6 Oct 2009 19:51:46 +1030
Message-ID: <200910061951.47231.rusty@rustcorp.com.au>
References: <200909300248.09630.rusty@rustcorp.com.au>
	<200909300941.24736.borntraeger@de.ibm.com>
	<4ACA1CBC.8020402@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4ACA1CBC.8020402@redhat.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: john cooper <john.cooper@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 6 Oct 2009 02:50:12 am john cooper wrote:
> It seems simply retiring use of the VIRTIO_BLK_F_IDENTIFY
> binary value should be sufficient.  The patch which
> implemented the cooperating logic in qemu was dropped
> due to the config space issue.

OK, I'll just remove it then.

Also, I've been convinced to just hand over the 20 byte serial number
since we're revisiting this.  It's simple, and there's no clear consensus.

Thanks,
Rusty.
