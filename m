From: Muli Ben-Yehuda <mulix@mulix.org>
Subject: Re: [virtio-dev] Zerocopy VM-to-VM networking using virtio-net
Date: Mon, 27 Apr 2015 16:08:15 +0300
Message-ID: <20150427130815.GD11968@needle>
References: <20150422170138.GA8388@stefanha-thinkpad.redhat.com>
	<CAA2XHbd_Wxs3O6ChSGouF3ZGH-SA0Lzw7OFVfvnuAXZmLAkZoA@mail.gmail.com>
	<CAJSP0QWtbzWwbvHYHVDJ2bccJ1wPZ0WA31bOH5UkGMhbkLF-Ng@mail.gmail.com>
	<CAA2XHbdvxTviZ-wxRVd87EuajcrOb1g=3Rafdyc5cXrzGbJMqA@mail.gmail.com>
	<CAJSP0QU=0KXC3uRjFGukNvKQkSLnSOMvXpEoLgzoxD7CRSx2iA@mail.gmail.com>
	<CAA2XHbed=GMwCAUN4uz4vJ=JZdWeik=D07vwiwV5natk9XSdCg@mail.gmail.com>
	<CAJSP0QW9dqvbqNVt0Ggk2d=Yd=jCQsbCqZA+TCEaGqU35wbDjg@mail.gmail.com>
	<553E2D07.9040406@siemens.com> <553E31DC.6040108@siemens.com>
	<CAJSP0QVLCN-=7V3K8CJL8n0sN_Zm=vpJzWksH9gbYEP+AU8ndQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAJSP0QVLCN-=7V3K8CJL8n0sN_Zm=vpJzWksH9gbYEP+AU8ndQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Rik van Riel <riel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Andrew Jones <drjones@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Luke Gorrie <luke@snabb.co>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 27, 2015 at 02:01:05PM +0100, Stefan Hajnoczi wrote:

> A hardware solution would be some kind of inter-guest interrupt
> injection.  I don't know VMX well enough to know whether that is
> possible on Intel CPUs.

It is: http://www.mulix.org/pubs/eli/eli.pdf.

(And there's hardware coming down the pipe that will make (some) of
the nasty tricks we used unnecessary).

Cheers,
Muli
