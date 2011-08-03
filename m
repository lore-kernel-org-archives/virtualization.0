From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv3] virtio-spec: 64 bit features, used/avail event, fixes
Date: Wed, 3 Aug 2011 19:39:23 +0300
Message-ID: <20110803163923.GA17244__17230.7485169314$1312389667$gmane$org@redhat.com>
References: <20110601102548.GA11013@redhat.com>
	<87ei3dxas0.fsf@rustcorp.com.au>
	<20110803160518.GA16563@redhat.com> <4E397425.90808@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4E397425.90808@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Krishna Kumar2 <krkumar2@in.ibm.com>, habanero@linux.vnet.ibm.com, kvm@vger.kernel.org, steved@us.ibm.com, Shirley Ma <mashirle@us.ibm.com>, virtualization@lists.linux-foundation.org, borntraeger@de.ibm.com, Tom Lendacky <tahm@linux.vnet.ibm.com>, avi@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Aug 03, 2011 at 06:15:33PM +0200, Gerd Hoffmann wrote:
>   Hi,
> 
> >E.g. with 32 bridges, and 32 devices behind each one,
> >the available 64K space gets us only 64 bytes per device.
> 
> 15 bridges (with io window enabled) max, the smallest io window you
> can assign to a bridge is 4k, and you need some space for the
> devices on the root bus ...
> 
> cheers,
>   Gerd


Hmm, wait, we could go 32 bit, then we are not limited to 32
bridges anymore, right? Does our bios support that?


-- 
MST
