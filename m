From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] vhost: fixes, vdpa
Date: Sat, 11 Apr 2020 09:38:05 -0700
Message-ID: <CAHk-=wg7sMywb2V8gifhpUDE=DWQTvg1wDieKVc0UoOSsOrynw@mail.gmail.com>
References: <20200406171124-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200406171124-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: tiwei.bie@intel.com, KVM list <kvm@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, tysand@google.com, eperezma@redhat.com, xiao.w.wang@intel.com, Nadav Amit <namit@vmware.com>, David Rientjes <rientjes@google.com>, yuri.benditovich@daynix.com, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Michal Hocko <mhocko@kernel.org>, lingshan.zhu@intel.com
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 6, 2020 at 2:11 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> The new vdpa subsystem with two first drivers.

So this one is really annoying to configure.

First it asks for vDPA driver for virtio devices (VIRTIO_VDPA) support.

If you say 'n', it then asks *again* for VDPA drivers (VDPA_MENU).

And then when you say 'n' to *that* it asks you for Vhost driver for
vDPA-based backend (VHOST_VDPA).

This kind of crazy needs to stop.

Doing kernel configuration is not supposed to be like some truly
horrendously boring Colossal Cave Adventure game where you have to
search for a way out of maze of twisty little passages, all alike.

                Linus
