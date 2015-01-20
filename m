From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 0/6] virtio: graceful failure with get == NULL
Date: Tue, 20 Jan 2015 16:59:15 +1030
Message-ID: <87oapuart0.fsf@rustcorp.com.au>
References: <1421160167-18498-1-git-send-email-mst@redhat.com>
	<20150113194909.GO21393@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150113194909.GO21393@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:
> On Tue, Jan 13, 2015 at 04:43:07PM +0200, Michael S. Tsirkin wrote:
>> virtio 1.0 says device configuration is optional, but most drivers treat it as
>> mandatory.  Even if presented by device, guest bios might disable the BAR
>> holding that configuration, so we can't assume it's there, but we also don't
>> want to fail if not in case drivers can cope with it's absence - such as caif
>> or rng.
>> 
>> Add code to drivers to check presence of get callback and fail gracefully.
>
> Rusty, in case it's not clear: I'd like to hear
> your opinion on these patches, since virtio pci modern
> driver I'm now preparing for submission, depends on this.

Just to note for anyone following, that these are now in my virtio-next
tree.

Cheers,
Rusty.
