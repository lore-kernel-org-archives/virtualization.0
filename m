From: Adam Litke <agl@us.ibm.com>
Subject: Re: virtio: Add memory statistics reporting to the balloon driver (V3)
Date: Thu, 19 Nov 2009 10:29:09 -0600
Message-ID: <1258648149.3464.23.camel__33374.2601950236$1258648219$gmane$org@aglitke>
References: <1258643169.3464.3.camel@aglitke>
	<1258643945.3464.5.camel@aglitke>  <4B0562A0.7040507@redhat.com>
	<1258646331.3464.18.camel@aglitke>  <4B056EB8.9020509@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4B056EB8.9020509@redhat.com>
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
Cc: linux-kernel@vger.kernel.org, Anthony Liguori <aliguori@us.ibm.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2009-11-19 at 18:13 +0200, Avi Kivity wrote:
> On 11/19/2009 05:58 PM, Adam Litke wrote:
> > On Thu, 2009-11-19 at 17:22 +0200, Avi Kivity wrote:
> >    
> >> On 11/19/2009 05:19 PM, Adam Litke wrote:
> >>      
> >>> Rusty and Anthony,
> >>> If I've addressed all outstanding issues, please consider this patch for
> >>> inclusion.  Thanks.
> >>>
> >>> +struct virtio_balloon_stat
> >>> +{
> >>> +	__le16 tag;
> >>> +	__le64 val;
> >>> +};
> >>> +
> >>>
> >>>        
> >> You're not doing endian conversion in the host?
> >>      
> > No.  I was following by example.  For the virtio_balloon, the existing
> > code is careful so that the guest always writes data in little endian.
> >    
> 
> I don't follow.  If the guest is careful to write little-endian, surely 
> the host must be equally careful to read little-endian?

That is true and, by my reading of the existing qemu virtio-balloon
device code, isn't virtio_balloon_set_config() on a big endian host
already broken?


-- 
Thanks,
Adam
