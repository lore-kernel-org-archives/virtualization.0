From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [RFC] kvm tools: Implement multiple VQ for virtio-net
Date: Mon, 14 Nov 2011 14:25:17 +0200
Message-ID: <CAOJsxLE4yRO+5XncrDEzVh5-RGXG+=HGTAmQ=bX=KMsDqf=feA__1265.93218087709$1321323160$gmane$org@mail.gmail.com>
References: <1321049521-26376-1-git-send-email-levinsasha928@gmail.com>
	<20111113102428.GD15322@redhat.com> <1321196430.2425.2.camel@sasha>
	<4EC07729.3050303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4EC07729.3050303@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias.hejun@gmail.com>
Cc: Krishna Kumar <krkumar2@in.ibm.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, gorcunov@gmail.com, Sasha Levin <levinsasha928@gmail.com>, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Nov 14, 2011 at 4:04 AM, Asias He <asias.hejun@gmail.com> wrote:
> Why both the bandwidth and latency performance are dropping so dramatically
> with multiple VQ?

What's the expected benefit from multiple VQs i.e. why are doing the
patches Sasha?
