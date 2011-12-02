From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Add virtio-scsi to the virtio spec
Date: Fri, 02 Dec 2011 11:21:44 +1030
Message-ID: <87ty5jre1r.fsf@rustcorp.com.au>
References: <1322661042-28191-1-git-send-email-pbonzini@redhat.com>
	<87sjl5rnj6.fsf@rustcorp.com.au> <4ED74102.6040207@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4ED74102.6040207@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, LKML <linux-kernel@vger.kernel.org>, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 01 Dec 2011 09:55:30 +0100, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 12/01/2011 04:14 AM, Rusty Russell wrote:
> > I'd prefer to see the spec only cover things
> > which are implemented and tested, otherwise the risk of a flaw in the
> > spec is really high in my experience.
> 
> In general I agree, and I did that for virtio-specific things such as 
> the eventq and the configuration space.  This is also why I don't want 
> to add untested controlq requests that people suggested.
> 
> However, there's tension between this and providing a complete SCSI 
> transport.  SCSI is roughly defined as a set of RPC interfaces ("Send 
> command", "Abort task", etc.) and transports provide the RPC protocol. 
> The SCSI command set changes relatively often, but the RPC interfaces 
> are pretty stable.  This stability limits the risk, and having a mapping 
> for all interfaces also makes future changes less likely.

OK, I expect that someone reading the spec will be SCSI-familiar more
than virtio-familiar, so it's more important that they be comfortable,
than that I be comfortable.

Thanks!
Rusty.
