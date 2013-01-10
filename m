From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH 1/2] move virtnet_send_command() above
	virtnet_set_mac_address()
Date: Thu, 10 Jan 2013 17:02:39 +0200
Message-ID: <20130110150239.GC30731@redhat.com>
References: <1357829141-25455-1-git-send-email-akong@redhat.com>
	<1357829141-25455-2-git-send-email-akong@redhat.com>
	<50EED588.9080706@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <50EED588.9080706@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jan 10, 2013 at 10:51:52PM +0800, Jason Wang wrote:
> On 01/10/2013 10:45 PM, akong@redhat.com wrote:
> > From: Amos Kong <akong@redhat.com>
> >
> > We will send vq command to set mac address in virtnet_set_mac_address()
> > a little fix of coding style
> 
> Maybe what you need is just a forward declaration.


Nah functions should be ordered sensibly.

> >
> > Signed-off-by: Amos Kong <akong@redhat.com>
