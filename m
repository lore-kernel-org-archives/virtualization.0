From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH V3 WIP 3/3] disable vhost_verify_ring_mappings check
Date: Thu, 28 Mar 2013 06:13:31 -0400 (EDT)
Message-ID: <8300718.16452772.1364465611936.JavaMail.root@redhat.com>
References: <20130328090416.GA18482@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130328090416.GA18482@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Kevin O'Connor <kevin@koconnor.net>, kvm@vger.kernel.org, seabios-devel <seabios@seabios.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

> I think it's the right thing to do, but maybe not the right place
> to do this, need to reset after all IO is done, before
> ring memory is write protected.

Our emails are crossing each other unfortunately, but I want to
reinforce this: ring memory is not write protected.  Remember that
SeaBIOS can even provide virtio-scsi access to DOS, so you must
not reset the device.  It must remain functional all the time,
and the OS's own driver will reset it when it's started.

Paolo
