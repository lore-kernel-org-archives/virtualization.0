From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] Export mm_update_next_owner function for vhost-net
Date: Mon, 17 Dec 2018 20:41:36 -0500
Message-ID: <20181217204124-mutt-send-email-mst__20995.8338215531$1545097179$gmane$org@kernel.org>
References: <1544676445-14897-1-git-send-email-gchen.guomin@gmail.com>
	<20181217113254.GA6971@infradead.org>
	<CAEEwsfQ9ARxJCZxy5bY70Aa0HYqwto-gROxT8fvrduNn0MVf=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAEEwsfQ9ARxJCZxy5bY70Aa0HYqwto-gROxT8fvrduNn0MVf=A@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: gchen chen <gchen.guomin@gmail.com>
Cc: kvm@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Dominik Brodowski <linux@dominikbrodowski.net>, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, "Luis R. Rodriguez" <mcgrof@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, gchen <guominchen@tencent.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Dec 18, 2018 at 09:39:16AM +0800, gchen chen wrote:
> Yes,=A0I think so.=A0
> and i think the point is that unuse_mm() can't directly set tsk->mm=3DNUL=
L.

So why can't unuse_mm call mm_update_next_owner?

-- =

MST
