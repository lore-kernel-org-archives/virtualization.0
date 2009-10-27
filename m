From: Avi Kivity <avi@redhat.com>
Subject: Re: performance regression in virtio-net in 2.6.32-rc4
Date: Tue, 27 Oct 2009 11:41:25 +0200
Message-ID: <4AE6C045.1070800__31391.8159147308$1256636563$gmane$org@redhat.com>
References: <20091026184835.GB26473@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20091026184835.GB26473@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 10/26/2009 08:48 PM, Michael S. Tsirkin wrote:
> Hi!
> I noticed a performance regression in virtio net: going from
> 2.6.31 to 2.6.32-rc4 I see this, for guest to host communication:
>
> Any tips on debugging this?
>    

Lacking better advice, a bisect can help as a last resort.  'git bisect 
start -- drivers/net drivers/virtio' will probably find it fastest.

-- 
error compiling committee.c: too many arguments to function
