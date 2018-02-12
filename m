From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v3 1/2] drm/virtio: Add window server support
Date: Mon, 12 Feb 2018 16:29:03 +0100
Message-ID: <20180212152903.24t6sdgthg2aptnn__162.98145424134$1518449241$gmane$org@sirius.home.kraxel.org>
References: <f07a5347-13fe-76c2-f971-3f02abebd3c9@collabora.com>
	<20180205160322.sntv5uoqp5o7flnh@sirius.home.kraxel.org>
	<fd557eb7-f539-2ecf-142c-8313b9f7ddb3@collabora.com>
	<20180206142302.vdjyqmnoypydci4t@sirius.home.kraxel.org>
	<04687943-847b-25a7-42ef-a21b4c7ef0cf@collabora.com>
	<38880e66-b676-1170-c2ca-5a5603c5b521@collabora.com>
	<20180212115242.z3qv5uejbnhgvd6o@sirius.home.kraxel.org>
	<eea72b9d-d180-6a57-81ce-4366dc0f2bcc@collabora.com>
	<20180212142730.g2646v77qsvzd5ff@sirius.home.kraxel.org>
	<6cf0c06a-b884-3251-166b-6ff3dec3ebc7@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <6cf0c06a-b884-3251-166b-6ff3dec3ebc7@collabora.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Zach Reizner <zachr@google.com>, kernel@collabora.com
List-Id: virtualization@lists.linuxfoundation.org

> > I was more thinking about a struct containing enough info to allow the
> > proxy on the host side find the buffer, something like:
> > 
> >     struct {
> >        enum type { stdvga, virtio-cpu, ... }
> >        pcislot device;
> >        union {
> >           int stdvga_pcibar_offset;
> >           int virtio_gpu_resource_id;
> >        }
> >     }
> > 
> > So when the guest proxy gets a message with a fd referencing a buffer it
> > would have to figure where the buffer is, rewrite the message into the
> > struct above for the host proxy.  The host proxy would rewrite the
> > message again for the server.
> 
> What I don't understand yet is how we can keep the buffer descriptions
> together with the protocol data that references them.
> 
> With SCM_RIGHTS, the FDs are placed in the ancillary data that "travels"
> together with the protocol data that references them.

Place the buffer description into the wayland extension protocol messages?

i.e. have some wl_virt_proxy protocol extension.  Then, for the stdvga case:

  (1) client sends wl_drm/create_prime_buffer request to the guest proxy
  (2) guest proxy rewrites this into wl_virt_proxy/create_buffer, or
      maybe a create_stdvga_buffer request, carrying all the information
      listed above, and sends it to the host proxy.
  (3) host proxy rewrites it again into a wl_shm_pool/create_buffer and
      forwards it to the server.

cheers,
  Gerd
