From: Vincent Legoll <vincent.legoll@gmail.com>
Subject: [PATCH, v2] virtio: make VIRTIO a menuconfig to ease disabling it
Date: Wed,  3 Jan 2018 10:49:17 +0100
Message-ID: <20180103094918.6106-1-vincent.legoll__36731.5582152971$1514972893$gmane$org@gmail.com>
References: <871sj7dgvr.fsf@concordia.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <871sj7dgvr.fsf@concordia.ellerman.id.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: Vincent Legoll <vincent.legoll@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

No need to get into the submenu to disable all VIRTIO-related
config entries.

This makes it easier to disable all VIRTIO config options
without entering the submenu. It will also enable one
to see that en/dis-abled state from the outside menu.

This is only intended to change menuconfig UI, not change
the config dependencies.

v2: Added "default y" to avoid breaking existing configs

Signed-off-by: Vincent Legoll <vincent.legoll@gmail.com>
