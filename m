From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 12/22] virtio_pci: allow duplicate capabilities.
Date: Thu, 21 Mar 2013 16:43:30 +0200
Message-ID: <20130321144330.GA1454@redhat.com>
References: <1363854584-25795-1-git-send-email-rusty@rustcorp.com.au>
	<1363854584-25795-13-git-send-email-rusty@rustcorp.com.au>
	<20130321102814.GC30493@redhat.com> <514B188A.3030502@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <514B188A.3030502@zytor.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 21, 2013 at 07:26:18AM -0700, H. Peter Anvin wrote:
> On 03/21/2013 03:28 AM, Michael S. Tsirkin wrote:
> > On Thu, Mar 21, 2013 at 06:59:33PM +1030, Rusty Russell wrote:
> >> Another HPA suggestion: that the device be allowed to offer duplicate
> >> capabilities, particularly so it can offer a mem and an I/O bar and let
> >> the guest decide (Linux guest probably doesn't care?).
> >>
> >> Cc: H. Peter Anvin <hpa@zytor.com>
> >> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> > 
> > I think guests is exactly the wrong place to decide,
> > it really does not know whether it's running on a
> > hypervisor with fast IO or fast memory.
> > Also, as long as we have an IO BAR, we have problems allocating it.
> > So I think we don't need this, see my suggestion
> > about fixed IO addresses instead.
> > 
> 
> The reason to support this is that a guest written to only handle one or
> the other doesn't prevent the hypervisor from offering the other to
> guests.  We probably want to specify that if the guest doesn't care, it
> should use the first one offered by the host.
> 
> 	-hpa


What are the configurations where having many ways is helpful?
Any examples?
