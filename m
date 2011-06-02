From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCHv3] virtio-spec: 64 bit features, used/avail event, fixes
Date: Thu, 02 Jun 2011 11:19:35 +0930
Message-ID: <87ei3dxas0.fsf__35185.3791079067$1306979997$gmane$org@rustcorp.com.au>
References: <20110601102548.GA11013@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20110601102548.GA11013@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org
Cc: Krishna Kumar2 <krkumar2@in.ibm.com>, habanero@linux.vnet.ibm.com, kvm@vger.kernel.org, steved@us.ibm.com, Shirley Ma <mashirle@us.ibm.com>, borntraeger@de.ibm.com, Tom Lendacky <tahm@linux.vnet.ibm.com>, avi@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 1 Jun 2011 13:25:48 +0300, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> Add an option to modify the notificatin
> hand-off in virtio to be basically like Xen:
> each side published an index, the other side only triggers
> an event when it crosses that index value
> (Xen event indexes start at 1, ours start at 0 for
> backward-compatiblity, but that's minor).
> 
> Since we've run out of bits in the 32 bit field,
> I added another 32 bit and bit 31 enables that.

OK.  I've applied this, and published it as the 0.9 draft.

Thanks!
Rusty.
