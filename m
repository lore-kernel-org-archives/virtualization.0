From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 2/3] virtio: indirect ring entries
	(VIRTIO_RING_F_INDIRECT_DESC)
Date: Tue, 19 May 2009 17:45:00 +0930
Message-ID: <200905191745.00563.rusty__5917.60181491754$1242721004$gmane$org@rustcorp.com.au>
References: <1229620222-22216-1-git-send-email-markmc@redhat.com>
	<200905172346.14498.rusty@rustcorp.com.au>
	<4A1027C3.3080109@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4A1027C3.3080109@redhat.com>
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
To: Avi Kivity <avi@redhat.com>
Cc: Mark McLoughlin <markmc@redhat.com>, Dor Laor <dor@redhat.com>, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 18 May 2009 12:35:39 am Avi Kivity wrote:
> Rusty Russell wrote:
> > No, it's true for block.  It has output parts, so we should reduce
> > threshold when it's full.  Network recvq is an example which should
> > reduce threshold when it's empty.
>
> You mean the header that contains the sector number?  It's a little
> incidental, but I guess it works.

Yes, the one which breaks is randomness.  You really do just throw buffers with 
no metadata in them and the request is implied. If/when we care, we can add a 
hint flag.

Cheers,
Rusty.
