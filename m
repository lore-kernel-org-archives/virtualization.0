From: "Rustad, Mark D" <mark.d.rustad@intel.com>
Subject: Re: [PATCH] virtio_pci: support enabling VFs
Date: Wed, 30 May 2018 16:44:07 +0000
Message-ID: <414C18B1-30FA-4AC0-B47D-F0FBF9832737@intel.com>
References: <20180530085521.26583-1-tiwei.bie@intel.com>
	<20180530192010-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2870778381115444531=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180530192010-mutt-send-email-mst@kernel.org>
Content-Language: en-US
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
Cc: "Duyck, Alexander H" <alexander.h.duyck@intel.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "Wang,
	Zhihong" <zhihong.wang@intel.com>, Bjorn Helgaas <bhelgaas@google.com>
List-Id: virtualization@lists.linuxfoundation.org

--===============2870778381115444531==
Content-Language: en-US
Content-Type: multipart/signed;
	boundary="Apple-Mail=_FB4DAD04-C672-49EE-BC0F-E8F33D4948E7";
	protocol="application/pgp-signature"; micalg=pgp-sha256

--Apple-Mail=_FB4DAD04-C672-49EE-BC0F-E8F33D4948E7
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii;
	delsp=yes;
	format=flowed

On May 30, 2018, at 9:22 AM, Michael S. Tsirkin <mst@redhat.com> wrote:

>> +static int virtio_pci_sriov_configure(struct pci_dev *pci_dev, int  
>> num_vfs)
>> +{
>> +	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
>> +	struct virtio_device *vdev = &vp_dev->vdev;
>> +	int (*sriov_configure)(struct pci_dev *pci_dev, int num_vfs);
>> +
>> +	if (!(vdev->config->get_status(vdev) & VIRTIO_CONFIG_S_DRIVER_OK))
>> +		return -EBUSY;
>> +
>> +	if (!__virtio_test_bit(vdev, VIRTIO_F_SR_IOV))
>> +		return -EINVAL;
>> +
>> +	sriov_configure = pci_sriov_configure_simple;
>> +	if (sriov_configure == NULL)
>> +		return -ENOENT;
>
> BTW what is all this trickery in aid of?

When SR-IOV support is not compiled into the kernel,  
pci_sriov_configure_simple is #defined as NULL. This allows it to compile  
in that case, even though there is utterly no way for it to be called in  
that case. It is an alternative to #ifs in the code.

--
Mark Rustad, Networking Division, Intel Corporation

--Apple-Mail=_FB4DAD04-C672-49EE-BC0F-E8F33D4948E7
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEE6ug8b0Wg+ULmnksNPA7/547j7m4FAlsO1NQACgkQPA7/547j
7m7fOBAApqkdKjNkDMyc4Fo/KLviVZCiv3VXJ6ftdR6iQcJPCj4fBJQkHYcs9hoH
FUc4GIuo6hFl84OgsbvVDfCQFg0yaO+rZp2lSNjTrEQ+By6Oh4vXe6wCPcu7/sDE
IDFR04g3U5dm/HohkQbbcNW/Um/CcBLdHgmJXWpsifNr8j+Au3SafiFbalfv7UFr
WUSGPKwCPzGJoGYIia824sWkUI/HdGRrhvxXefnq3DSObrxxX+Hj7lqxgfg7r8c7
CfZ0NmeykKIyuGLHZLyKhOispM3cw9145QiquP8tHVnvxUTqrYNhzMiSZTYqsBY2
VQSGCf+paHgFPIKqJIZpNIAN/A3YKynFZA+qq8XrDr5AT5UA9HrLbe8fheooamV5
r21k4+05AIwDOTV1AlYMHdpzUTNs8SLe5mwNL+4RpvQlKV3Kptv2NFzv13fmSPEo
SHcRexSpBP4eSxVOIhW3j64M4aY7vg5MQshD+geqhgA4wVpb6Wqct3GHdnxqSoEt
z5wQrQD8jB8glt8HpIrWzMDyp774QKYnqlpddA6U9keUYP1NS5iNMzbCdT2/TZIx
s266G3ckoi0E5qs72bEgYSyd2g4yvmLl7vZ+FWJqpypFUE4Dj7cbGXlBu4Ib8haq
IZBRPVopLACSRpAl2exZXwnT41mvznompRSHxigfe79w64JHwgM=
=kV9d
-----END PGP SIGNATURE-----

--Apple-Mail=_FB4DAD04-C672-49EE-BC0F-E8F33D4948E7--

--===============2870778381115444531==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2870778381115444531==--
