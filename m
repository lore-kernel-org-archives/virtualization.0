From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v3] Add virtio-scsi to the virtio spec
Date: Tue, 07 Feb 2012 10:06:04 +1030
Message-ID: <87ehu7ilgb.fsf__36930.8268571787$1328574618$gmane$org@rustcorp.com.au>
References: <1328439694-18705-1-git-send-email-pbonzini@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1328439694-18705-1-git-send-email-pbonzini@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>, virtualization <virtualization@lists.linux-foundation.org>
Cc: linux-scsi <linux-scsi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sun,  5 Feb 2012 12:01:34 +0100, Paolo Bonzini <pbonzini@redhat.com> wrote:
> Hi Rusty,
> 
> here is the specification for a virtio-based SCSI host (controller, HBA,
> you name it) so that you can apply it to the spec document and publish it.
> 
> I changed the index from 7 to 8 to account for the rpmsg device,
> and added a feature bit to tell the guest in advance whether the host
> supports hotplug.  Otherwise there is no change from v2.
> 
> Paolo

Thanks, applied!

I will release a new draft version shortly.

Cheers,
Rusty.
